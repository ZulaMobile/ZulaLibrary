//
//  SMContainerViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContainerViewController.h"
#import "SDSegmentedControl.h"
#import "SMProgressHUD.h"
#import "UIViewController+SSToolkitAdditions.h"

#import "SMAppDescription.h"
#import "SMComponentDescription.h"
#import "SMComponentFactory.h"
#import "SMContainer.h"

#define subViewTag 665

@interface SMContainerViewController ()

- (void)onButton:(id)submenu;
- (void)displayComponentWithDescription:(SMComponentDescription *)description;

@end

@implementation SMContainerViewController
{
    // active content controller
    UIViewController *activeContentViewController;
}
@synthesize container, subMenu;


- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    self.subMenu = [[SDSegmentedControl alloc] initWithItems:[NSArray array]];
    [self.subMenu setFrame:CGRectMake(0, 0, CGRectGetWidth(screenRect), 44)];
    [self.subMenu setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    //[self.subMenu applyAppearances:self.componentDesciption.appearance];
    self.subMenu.segmentedControlStyle = UISegmentedControlStylePlain;
    [self.subMenu addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventValueChanged];
    //self.subMenu.arrowHeightFactor *= -1.0;
    
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
    if (self.container) {
        [self applyContents];
        return;
    }
    
    // start preloader
    [SMProgressHUD show];
    
    NSString *url = [self.componentDesciption url];
    [SMContainer fetchWithURLString:url completion:^(SMContainer *theContainer, SMServerError *error) {
        // end preloader
        [SMProgressHUD dismiss];
        
        if (error) {
            DDLogError(@"Content page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        [self setContainer:theContainer];
        [self applyContents];
    }];
    
}

- (void)applyContents
{
    [self setTitle:self.container.title];
    
    // set the content components
    SMComponentDescription *firstComponentDesc;
    int i = 0;
    for (SMComponentDescription *desc in self.container.components) {
        if (i == 0) {
            firstComponentDesc = desc;
        }
        
        [self.subMenu insertSegmentWithTitle:desc.title atIndex:i animated:YES];
        i++;
    }
    
    // display the 1st one
    [self displayComponentWithDescription:firstComponentDesc];
    self.subMenu.selectedSegmentIndex = 0;
}

#pragma mark - private methods

- (void)onButton:(id)submenu
{
    NSInteger selectedIndex = [(SDSegmentedControl *)subMenu selectedSegmentIndex];
    SMComponentDescription *thedesc = [self.container.components objectAtIndex:selectedIndex];
    [self displayComponentWithDescription:thedesc];
}

- (void)displayComponentWithDescription:(SMComponentDescription *)description
{
    // remove the old view
    UIView *currentView = [self.view viewWithTag:subViewTag];
    [currentView removeFromSuperview];
    activeContentViewController = nil;
    
    // create component
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    activeContentViewController = [SMComponentFactory componentWithDescription:description
                                                                 forNavigation:appDescription.navigationDescription];
    [(SMBaseComponentViewController *)activeContentViewController setComponentNavigationDelegate:self];
    
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
    [activeContentViewController.view setTag:subViewTag];
    
    [self.view addSubview:activeContentViewController.view];
    
    // send subview to back
    [self.subMenu removeFromSuperview];
    [self.view addSubview:self.subMenu];
}

#pragma mark - component navigation delegate

- (void)component:(SMBaseComponentViewController *)component
willShowViewController:(UIViewController *)controller
         animated:(BOOL)animated
{
    [self.navigationController pushViewController:controller animated:YES];
}

@end
