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

@interface SMHomePageViewController ()

/**
 scroll view as a wrapper for content view
 */
@property (nonatomic, strong) SMScrollView *scrollView;

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

@end
