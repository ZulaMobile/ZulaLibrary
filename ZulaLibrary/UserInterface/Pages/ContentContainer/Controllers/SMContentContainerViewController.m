//
//  SMContentContainerViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContentContainerViewController.h"
#import "UIViewController+SSToolkitAdditions.h"
#import "SMProgressHUD.h"

#import "SMComponentDescription.h"
#import "SMContentContainer.h"
#import "SMContentPage.h"
#import "SMSubMenuView.h"
#import "SMContentViewController.h"

@interface SMContentContainerViewController ()
- (void)onButton:(SMSubMenuView *)submenu;
@end

@implementation SMContentContainerViewController
{
    // active content controller
    SMContentViewController *activeContentViewController;
}
@synthesize subMenu;
@synthesize contentContainer;

- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    self.subMenu = [[SMSubMenuView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(screenRect), 34)];
    //[self.subMenu applyAppearances:self.componentDesciption.appearance];
    [self.subMenu setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    [self.subMenu addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.subMenu];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // fetch the data and load the model
    [self fetchContents];
}

#pragma mark - overridden methods

- (void)fetchContents
{
    // if data is already set, no need to fetch contents
    if (self.contentContainer) {
        [self applyContents];
        return;
    }
    
    // start preloader
    [SMProgressHUD show];
    
    NSString *url = [self.componentDesciption url];
    [SMContentContainer fetchWithURLString:url completion:^(SMContentContainer *theContentContainer, SMServerError *error) {
        // end preloader
        [SMProgressHUD dismiss];
        
        if (error) {
            DDLogError(@"Content page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        [self setContentContainer:theContentContainer];
        [self applyContents];
        
    }];
}

- (void)applyContents
{
    [self setTitle:self.contentContainer.title];
    
    // set the content components
    int i = 0;
    for (SMContentPage *contentPage in self.contentContainer.components) {
        // add it to the menu
        [self.subMenu addButtonWithTitle:contentPage.title tag:i];
        i++;
    }
}

#pragma mark - private methods

- (void)onButton:(SMSubMenuView *)submenu
{
    int submenuTag = 666;
    SMContentPage *contentPage = [self.contentContainer.components objectAtIndex:subMenu.activeButton.tag];
    
    // remove the old view
    UIView *currentView = [self.view viewWithTag:submenuTag];
    [currentView removeFromSuperview];
    activeContentViewController = nil;
    
    // create a controller for this
    activeContentViewController = [[SMContentViewController alloc] initWithDescription:self.componentDesciption];
    [activeContentViewController setContentPage:contentPage];
    
    // add controller's view to self.view
    [activeContentViewController.view setFrame:CGRectMake(0,
                                                    CGRectGetHeight(self.subMenu.frame),
                                                    CGRectGetWidth(self.view.frame),
                                                    CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.subMenu.frame))];
    [activeContentViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin    |
                                                             UIViewAutoresizingFlexibleHeight       |
                                                             UIViewAutoresizingFlexibleLeftMargin   |
                                                             UIViewAutoresizingFlexibleRightMargin  |
                                                             UIViewAutoresizingFlexibleWidth];
    [activeContentViewController.view setTag:submenuTag];
    
    [self.view addSubview:activeContentViewController.view];
}

@end
