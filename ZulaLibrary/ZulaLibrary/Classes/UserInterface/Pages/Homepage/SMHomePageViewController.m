//
//  SMHomePageControllerViewController.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMHomePageViewController.h"
#import "Macros.h"
#import "SMServerError.h"

#import "SMAppDescription.h"
#import "SMComponentDescription.h"
#import "SMScrollView.h"
#import "SMHomePage.h"
#import "UIViewController+SMAdditions.h"
#import "SMLinks.h"
#import "SMNavigation.h"
#import "SMAppDelegate.h"
#import "SMImageView.h"

#import "SMImageComponentStrategy.h"
#import "SMDefaultAppDelegate.h"

@interface SMHomePageViewController ()

/**
 scroll view as a wrapper for content view
 */
@property (nonatomic, strong) SMScrollView *scrollView;

- (void)onComponentButton:(SMLinks *)sender;
- (void)setupLinks;

@end

@implementation SMHomePageViewController
{
    SMImageComponentStrategy *imageComponentDelegate;
    UIView *signature;
}
@synthesize logoView, linksView;

- (id)initWithDescription:(SMComponentDescription *)description
{
    self = [super initWithDescription:description];
    if (self) {
        // the homepage title is fixed to app title
        SMAppDescription *appDesc = [SMAppDescription sharedInstance];
        [self setTitle:[appDesc appTitle]];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];

    self.logoView = [[SMImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160.0)];
    [self.logoView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin];
    [self.logoView applyAppearances:[self.componentDesciption.appearance objectForKey:@"logo"]];
    [self.logoView setHidden:YES];
    
    self.scrollView = [[SMScrollView alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     screenRect.size.width,
                                                                     screenRect.size.height)];
    [self.scrollView applyAppearances:self.componentDesciption.appearance];
    [self.scrollView setBackgroundColor:[UIColor clearColor]];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    [self.scrollView addSubview:self.logoView];
    [self.view addSubview:self.scrollView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.linksView = [[SMLinks alloc] initWithFrame:
                          CGRectMake(0.0f,
                                     0.0f,
                                     CGRectGetWidth(self.view.frame) - self.padding.x * 2,
                                     CGRectGetHeight(self.view.frame)  - self.padding.y * 2)];
    [self.linksView applyAppearances:[self.componentDesciption.appearance objectForKey:@"links"]];
    [self.linksView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    [self.linksView addTarget:self action:@selector(onComponentButton:) forControlEvents:UIControlEventValueChanged];
    [self.linksView setBackgroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:self.linksView];
    
    //[self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(homePageLinks.frame))];
    
    /*
    UIResponder<SMAppDelegate> *appDelegate = (UIResponder<SMAppDelegate> *)[[UIApplication sharedApplication] delegate];
    UIViewController<SMNavigation> *navigation = (UIViewController<SMNavigation> *)[appDelegate navigationComponent];
    int i = 0, j = 0;
    for (UIViewController *component in navigation.components) {
        if ([component isKindOfClass:[UINavigationController class]]) {
            i++;
            continue;
        }
        // place each component buttons
        UIButton *componentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [componentButton setFrame:CGRectMake(padding,
                                            120 + j * (40 + padding),
                                            CGRectGetWidth(self.view.frame) - padding * 2,
                                            40)];
        [componentButton setTag:i];
        [componentButton addTarget:self action:@selector(onComponentButton:) forControlEvents:UIControlEventTouchUpInside];
        //DDLogVerbose(@"%d. component button: %f, %f, %f, %f", i, componentButton.frame.origin.x, componentButton.frame.origin.y, componentButton.frame.size.width, componentButton.frame.size.height);
        [componentButton setTitle:component.title forState:UIControlStateNormal];
        [self.scrollView addSubview:componentButton];
        i++; j++;
    }*/
}

- (void)fetchContents
{
    [super fetchContents];
    
    NSString *url = [self.componentDesciption url];
    [SMHomePage fetchWithURLString:url completion:^(SMHomePage *_homePage, SMServerError *error) {
        if (error) {
            NSLog(@"Home page fetch contents error|%@", [error description]);
            // show error
            [self displayErrorString:error.localizedDescription];
            return;
        }
        
        self.model = _homePage;
        [self applyContents];
    }];
}

- (void)applyContents
{
    // setup links
    [self setupLinks];
    
    SMHomePage *homePage = (SMHomePage *)self.model;
    
    BOOL logoWasHidden = [self.logoView isHidden];
    if (homePage.logoUrl) {
        [self.logoView setHidden:NO];
        [self.logoView setImageWithProgressBarAndUrl:homePage.logoUrl];
        
        imageComponentDelegate = [[SMImageComponentStrategy alloc] initWithComponent:self];
        [self.logoView setTouchDelegate:imageComponentDelegate];
    }
    
    if (homePage.backgroundUrl)
        [self.backgroundImageView setImageWithURL:homePage.backgroundUrl];
    
    // rearrange positions
    if (homePage.logoUrl && logoWasHidden) {
        CGRect linksFrame = self.linksView.frame;
        linksFrame.origin.y += CGRectGetHeight(self.logoView.frame);
        [self.linksView setFrame:linksFrame];
        
        CGSize scrollContentSize = self.scrollView.contentSize;
        scrollContentSize.height += CGRectGetHeight(self.logoView.frame);
        [self.scrollView setContentSize:scrollContentSize];
    }
    
    // zulamobile signature
    signature = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollView.contentSize.height, CGRectGetWidth(self.scrollView.frame), 20.0f)];
    
    UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zularesources.bundle/signature"]];
    [im setFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame) - 69 - 10, 4, 69, 12)];
    [im setClipsToBounds:YES];
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:9.0f];
    CGSize lblSize = [@"App craeted by" sizeWithFont:font];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(im.frame.origin.x - lblSize.width - 2, 2, lblSize.width, 20)];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setFont:font];
    [lbl setText:@"App created by"];
    
    [signature addSubview:lbl];
    [signature addSubview:im];
    [self.scrollView addSubview:signature];
    
    // expand scrollview content by signature content plus padding
    CGSize scrollViewContentSize = self.scrollView.contentSize;
    scrollViewContentSize.height += CGRectGetHeight(signature.frame) + 10;
    [self.scrollView setContentSize:scrollViewContentSize];
    
    [super applyContents];
}

#pragma mark - private methods

- (void)onComponentButton:(SMLinks *)sender
{
    UIResponder<SMAppDelegate> *appDelegate = (UIResponder<SMAppDelegate> *)[[UIApplication sharedApplication] delegate];
    UIViewController<SMNavigation> *navigation = (UIViewController<SMNavigation> *)[appDelegate navigationComponent];
    UIViewController *component = [navigation componentFromComponentDescription:sender.selectedComponentDescription];
    
    [navigation navigateComponent:component fromComponent:self];
}

- (void)setupLinks
{
    SMHomePage *homePage = (SMHomePage *)self.model;
    
    // place links, get available components to show and pass them to the links view.
    UIResponder<SMAppDelegate> *appDelegate = (UIResponder<SMAppDelegate> *)[[UIApplication sharedApplication] delegate];
    UIViewController<SMNavigation> *navigation = (UIViewController<SMNavigation> *)[appDelegate navigationComponent];
    
    NSMutableArray *componentDescriptions = [NSMutableArray arrayWithCapacity:[navigation.componentDescriptions count]];
    for (SMComponentDescription *componentDescription in navigation.componentDescriptions) {
        
        // if it is a navigation controller, we disable them to show up in the homepage links
        // this will prevent the error of pushing navigation controller
        // also this will allow us to disable menu in tabbar navigation
        if ([componentDescription.type isEqualToString:@"HomePageComponent"]) {
            continue;
        }
        
        // we only display the components that are allowed by the homepage component
        BOOL componentIsAllowed = YES;
        if (homePage.components) {
            componentIsAllowed = NO;
            for (NSString *slug in homePage.components) {
                if ([componentDescription.slug isEqualToString:slug]) {
                    componentIsAllowed = YES;
                    continue;
                }
            }
        }
        
        if (componentIsAllowed) {
            [componentDescriptions addObject:componentDescription];
        }
    }
    
    [self.linksView setComponentDescriptions:[NSArray arrayWithArray:componentDescriptions]];
    [self.linksView applyAppearances:[self.componentDesciption.appearance objectForKey:@"links"]];
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(linksView.frame))];
}

@end
