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
#import "SMMainView.h"
#import "SMImageView.h"
#import "UIViewController+SSToolkitAdditions.h"
#import "UIImageView+WebCache.h"

@interface SMBaseComponentViewController ()

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
        padding = 10.0;
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
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    SMMainView *view = [[SMMainView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [view applyAppearances:self.componentDesciption.appearance];
    
    // get the app description for background image
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    
    // set background image
    self.backgroundImageView = [[SMImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
    [self.backgroundImageView setAutoresizesSubviews:UIViewAutoresizingFlexibleAll];
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
}

- (void)fetchContents
{
    // must be overridden
}

- (void)applyContents
{
    // must be overridden
}

- (void)applyNavbarIconWithUrl:(NSURL *)navbarIconUrl
{
    if (!navbarIconUrl) {
        if (self.navigationItem.titleView)
            self.navigationItem.titleView = nil;
        return;
    }
    UIImageView *navbarImage = [[UIImageView alloc] init];
    [navbarImage setImageWithURL:navbarIconUrl success:^(UIImage *image, BOOL cached) {
        self.navigationItem.titleView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    } failure:^(NSError *error) {
        //
    }];
    self.navigationItem.titleView = navbarImage;
}

@end
