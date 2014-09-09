//
//  SMContentContainerViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContentContainerViewController.h"
#import "ZulaLibrary.h"
#import "Macros.h"

#import "SDSegmentedControl.h"
#import "UIViewController+SMAdditions.h"
#import "UIColor+ZulaAdditions.h"

#import "SMComponentDescription.h"
#import "SMContentContainer.h"
#import "SMContentPage.h"
#import "SMSubMenuView.h"
#import "SMContentViewController.h"

#define contentViewTag 664

@interface SMContentContainerViewController ()
- (void)onButton:(id)submenu;
@end

@implementation SMContentContainerViewController
{
    // active content controller
    SMContentViewController *activeContentViewController;
}
@synthesize subMenu;

- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    self.subMenu = [[SDSegmentedControl alloc] initWithItems:[NSArray array]];
    [self.subMenu setFrame:CGRectMake(0, 0, CGRectGetWidth(screenRect), 44)];
    [self.subMenu setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    [self.subMenu addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventValueChanged];
    //self.subMenu.arrowHeightFactor *= -1.0;
    
    /*
    UIColor *navBarBackgroundColor = self.navigationController.navigationBar.backgroundColor;
    if (!navBarBackgroundColor) {
        navBarBackgroundColor = [UIColor colorWithHex:@"CCCCCC"];
    }*/
    
    /*
    [self.subMenu changeBackgroundColor:[navBarBackgroundColor darkerColor]];
    [self.subMenu setClipsToBounds:NO];
    [self.subMenu setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    [self.subMenu addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventValueChanged];
    */
    
    
    
    [self.view addSubview:self.subMenu];
}

#pragma mark - overridden methods

- (void)fetchContents
{
    [super fetchContents];
    
    NSString *url = [self.componentDesciption url];
    [SMContentContainer fetchWithURLString:url completion:^(SMContentContainer *theContentContainer, SMServerError *error) {
        
        if (error) {
            NSLog(@"Content page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        self.model = theContentContainer;
        [self applyContents];
        
    }];
}

- (void)applyContents
{
    SMContentContainer *contentContainer = (SMContentContainer *)self.model;
    
    [self setTitle:contentContainer.title];
    
    // set the content components
    SMContentPage *firstContentPage;
    int i = 0;
    for (SMContentPage *contentPage in contentContainer.components) {
        if (i == 0) {
            firstContentPage = contentPage;
        }
        
        // add it to the menu
        [self.subMenu insertSegmentWithTitle:contentPage.title atIndex:i animated:YES];
        i++;
    }
    
    // display the 1st one
    [self displayContentPage:firstContentPage];
    self.subMenu.selectedSegmentIndex = 0;
    
    [self applyContents];
}

#pragma mark - private methods

- (void)onButton:(id)submenu
{
    SMContentContainer *contentContainer = (SMContentContainer *)self.model;
    NSInteger selectedIndex = [(SDSegmentedControl *)subMenu selectedSegmentIndex];
    SMContentPage *contentPage = [contentContainer.components objectAtIndex:selectedIndex];
    [self displayContentPage:contentPage];
}

- (void)displayContentPage:(SMContentPage *)contentPage
{
    // remove the old view
    UIView *currentView = [self.view viewWithTag:contentViewTag];
    [currentView removeFromSuperview];
    activeContentViewController = nil;
    
    // create a controller for this
    activeContentViewController = [[SMContentViewController alloc] initWithDescription:self.componentDesciption];
    activeContentViewController.model = contentPage;
    
    // add controller's view to self.view
    float pullUp = 5.0;
    [activeContentViewController.view setFrame:CGRectMake(0,
                                                          CGRectGetHeight(self.subMenu.frame) - pullUp,
                                                          CGRectGetWidth(self.view.frame),
                                                          CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.subMenu.frame) + pullUp)];
    [activeContentViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin    |
     UIViewAutoresizingFlexibleHeight       |
     UIViewAutoresizingFlexibleLeftMargin   |
     UIViewAutoresizingFlexibleRightMargin  |
     UIViewAutoresizingFlexibleWidth];
    [activeContentViewController.view setTag:contentViewTag];
    
    [self.view addSubview:activeContentViewController.view];
    
    // send subview to back
    [self.subMenu removeFromSuperview];
    [self.view addSubview:self.subMenu];
}

@end
