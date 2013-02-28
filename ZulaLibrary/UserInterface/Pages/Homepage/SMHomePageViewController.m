//
//  SMHomePageControllerViewController.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMHomePageViewController.h"
#import "SMComponentDescription.h"
#import "SMScrollView.h"
#import "SMProgressHUD.h"
#import "SMHomePage.h"
#import "UIViewController+SSToolkitAdditions.h"

#import "SMNavigation.h"
#import "SMAppDelegate.h"

@interface SMHomePageViewController ()

/**
 scroll view as a wrapper for content view
 */
@property (nonatomic, strong) SMScrollView *scrollView;
- (void)onComponentButton:(UIButton *)sender;
@end

@implementation SMHomePageViewController

- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];

    self.scrollView = [[SMScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [self.scrollView applyAppearances:self.componentDesciption.appearance];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    self.logoView = [[SMImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100.0)];
    [self.logoView setAutoresizesSubviews:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin];
    [self.logoView applyAppearances:[self.componentDesciption.appearance objectForKey:@"logo"]];
    
    [self.scrollView addSubview:self.logoView];
    [self.view addSubview:self.scrollView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // By default, homepage doesn't have navigation bar
    [self.navigationController setNavigationBarHidden:YES];
    
    // fetch the contents
    [self fetchContents];
    
    // place links
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
    }
}

- (void)fetchContents
{
    [SMProgressHUD show];
    [SMHomePage fetchWithCompletion:^(SMHomePage *homePage, NSError *error) {
        [SMProgressHUD dismiss];
        if (error) {
            DDLogError(@"Home page fetch contents error|%@", [error description]);
            // show error
            [self displayErrorString:NSLocalizedString(@"We encountered an error, Please try again", nil)];
            return;
        }
        
        if (homePage.logoUrl)
            [self.logoView setImageWithURL:homePage.logoUrl];
        
        if (homePage.backgroundUrl)
            [self.backgroundImageView setImageWithURL:homePage.backgroundUrl];
    }];
}

#pragma mark - private methods

- (void)onComponentButton:(UIButton *)sender
{
    UIResponder<SMAppDelegate> *appDelegate = (UIResponder<SMAppDelegate> *)[[UIApplication sharedApplication] delegate];
    UIViewController<SMNavigation> *navigation = (UIViewController<SMNavigation> *)[appDelegate navigationComponent];
    UIViewController *component = (UIViewController *)[[navigation components] objectAtIndex:sender.tag];
    
    [navigation navigateComponent:component fromComponent:self];
}

@end
