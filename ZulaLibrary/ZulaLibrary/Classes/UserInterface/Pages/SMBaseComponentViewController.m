//
//  SMBaseComponentViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"
#import "SMComponentDescription.h"
#import "SMAppDescription.h"
#import "SMNavigationDescription.h"
#import "SMMainView.h"
#import "SMImageView.h"
#import "UIViewController+SMAdditions.h"
#import "UIImageView+WebCache.h"
#import "SMComponentModuleManager.h"
#import "SMComponentModule.h"


@interface SMBaseComponentViewController ()
- (BOOL)navigationHasBackgroundImage;
@end

@implementation SMBaseComponentViewController
@synthesize componentDesciption = _componentDesciption;
@synthesize componentNavigationDelegate;

- (id)initWithDescription:(SMComponentDescription *)description
{
    self = [super init];
    if (self) {
        [self setComponentDesciption:description];
        
        // configure component
        [self setTitle:self.componentDesciption.title];
        
        // padding default value
        self.padding = CGPointMake(10.0f, 10.0f);
        
        // add modules
        self.modules = [SMComponentModuleManager modulesForComponent:self];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // navbar enable/disable
    NSDictionary *navbarIcon = [self.componentDesciption.appearance objectForKey:@"navbar_icon"];
    if (navbarIcon && [navbarIcon objectForKey:@"disabled"]) {
        BOOL disabled = [[navbarIcon objectForKey:@"disabled"] boolValue];
        [self.navigationController setNavigationBarHidden:disabled];
    } else {
        [self.navigationController setNavigationBarHidden:NO];
    }
}

- (void)loadView
{
    SMMainView *view = [[SMMainView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    [view applyAppearances:self.componentDesciption.appearance];
    
    // get the app description for background image
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    
    // set background image
    self.backgroundImageView = [[SMImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
    [self.backgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    [self.backgroundImageView applyAppearances:[self.componentDesciption.appearance objectForKey:@"bg_image"]];
    [self.backgroundImageView setImageWithUrlString:appDescription.bgImageUrl];
    
    // navigation bar
    /*
    NSInteger displayNavBar = [[self.componentDesciption.appearance objectForKey:@"display_navbar"] integerValue];
    if (displayNavBar == 1) {
        [self.navigationController setNavigationBarHidden:NO];
    } else {
        [self.navigationController setNavigationBarHidden:YES];
    }*/
    
    // set view
    [view addSubview:self.backgroundImageView];
    [view sendSubviewToBack:self.backgroundImageView];
    [self setView:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // the transculent navbar setting for ios7
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.navigationController.navigationBar.translucent = YES;
        self.automaticallyAdjustsScrollViewInsets = YES;
        //self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // notify modules
    for (id<SMComponentModule> module in self.modules) {
        if ([module respondsToSelector:@selector(componentViewDidLoad)]) {
            [module componentViewDidLoad];
        }
    }
    
    // fetch the contents
    if ([self shouldFetchContents]) {
        [self fetchContents];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // change navigation back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", nil)
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:nil
                                                                  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    // disable the title view if navbar background exists
    [self navigationHasBackgroundImage];
}

- (BOOL)shouldFetchContents
{
    // check if any module thinks that we shouldn't fetch new contents
    for (id<SMComponentModule> module in self.modules) {
        if ([module respondsToSelector:@selector(componentShouldFetchContents)]) {
            if (![module componentShouldFetchContents]) return NO;
        }
    }
    
    return YES;
}

- (void)fetchContents
{
    // must be overridden
    
    // notify modules
    for (id<SMComponentModule> module in self.modules) {
        if ([module respondsToSelector:@selector(componentWillFetchContents)]) {
            [module componentWillFetchContents];
        }
    }
}

- (void)applyContents
{
    // must be overridden
    
    // notify modules
    for (id<SMComponentModule> module in self.modules) {
        if ([module respondsToSelector:@selector(componentDidFetchContent:)]) {
            [module componentDidFetchContent:self.model];
        }
    }
}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)applyNavbarIconWithUrl:(NSURL *)navbarIconUrl
{
#warning fix this, move it to a better place
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zularesources.bundle/Left_Reveal_Icon"]
                                                                                 style:UIBarButtonItemStyleBordered
                                                                                target:self
                                                                                action:@selector(goback)];
    }
    
    if (!navbarIconUrl) {
        if (![self navigationHasBackgroundImage]) {
            if (self.navigationItem.titleView)
                self.navigationItem.titleView = nil;
        }
        return;
    }
    UIImageView *navbarImage = [[UIImageView alloc] init];
    [navbarImage setImageWithURL:navbarIconUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        self.navigationItem.titleView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    }];
    //self.navigationItem.titleView = navbarImage;
    
}

#pragma mark - private methods

- (BOOL)navigationHasBackgroundImage
{
    // disable the navigation title, if background image exists
    SMNavigationDescription *navDesc = [[SMAppDescription sharedInstance] navigationDescription];
    NSString *bgImage = [navDesc.data objectForKey:@"navbar_bg_image"];
    if (bgImage && ![bgImage isEqualToString:@""]) {
        self.navigationItem.titleView = [[UIView alloc] init];
        return YES;
    }
    
    return NO;
}

@end


@implementation SMBaseComponentViewController (ModuleAdditions)

- (void)removeModuleByClass:(Class)cls
{
    NSMutableArray *tmpModules = [NSMutableArray arrayWithCapacity:[self.modules count]];
    for (id<SMComponentModule> module in self.modules) {
        if (![module isKindOfClass:cls]) {
            [tmpModules addObject:module];
        }
    }
    self.modules = [NSArray arrayWithArray:tmpModules];
}

- (void)addModuleByClass:(Class)cls
{
    // instantiate the modules
    id<SMComponentModule> module = [[cls alloc] initWithComponent:self];
    
    // add it the the array
    [self addModule:module];
}

- (void)addModule:(id)module
{
    NSMutableArray *tmpModules = [NSMutableArray arrayWithArray:self.modules];
    [tmpModules addObject:module];
    self.modules = [NSArray arrayWithArray:tmpModules];
}

@end