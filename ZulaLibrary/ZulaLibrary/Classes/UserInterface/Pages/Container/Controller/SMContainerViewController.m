//
//  SMContainerViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContainerViewController.h"
#import "SDSegmentedControl.h"
#import "UIViewController+SMAdditions.h"
#import "Macros.h"
#import "SMServerError.h"

#import "SMAppDescription.h"
#import "SMComponentDescription.h"
#import "SMComponentFactory.h"
#import "SMContainer.h"

#import "SMSwipeBackModule.h"
#import "SMComponentModule.h"


#define subViewTag 665

@interface SMContainerViewController ()

- (void)onButton:(id)submenu;
- (void)displayComponentWithDescription:(SMComponentDescription *)description;
- (void)swipeToDeltaIndex:(NSInteger)deltaIndex;

@end

@implementation SMContainerViewController
{
    // active content controller
    UIViewController *activeContentViewController;
}
@synthesize subMenu;

- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    self.subMenu = [[SDSegmentedControl alloc] initWithItems:[NSArray array]];
    [self.subMenu setFrame:CGRectMake(0.0f, 60.0f, CGRectGetWidth(screenRect), 44)];
    [self.subMenu setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    //[self.subMenu applyAppearances:self.componentDesciption.appearance];
    [self.subMenu addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventValueChanged];
    //self.subMenu.arrowHeightFactor *= -1.0;

    [self.view addSubview:self.subMenu];
}

#pragma mark - overridden methods

- (void)fetchContents
{
    [super fetchContents];
    
    NSString *url = [self.componentDesciption url];
    [SMContainer fetchWithURLString:url completion:^(SMContainer *theContainer, SMServerError *error) {
        
        if (error) {
            NSLog(@"Content page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        self.model = theContainer;
        [self applyContents];
    }];
    
}

- (void)applyContents
{
    SMContainer *container = (SMContainer *)self.model;
    
    [self setTitle:container.title];
    
    // get the initial sub component index
    NSDictionary *itemsAppearance = [self.componentDesciption.appearance objectForKey:@"items"];
    NSInteger initial = 0;
    if (itemsAppearance) {
        initial = [[itemsAppearance objectForKey:@"initial"] integerValue];
    }
    
    // set the content components
    SMComponentDescription *firstComponentDesc;
    int i = 0;
    for (SMComponentDescription *desc in container.components) {
        if (i == initial) {
            firstComponentDesc = desc;
        }
        
        [self.subMenu insertSegmentWithTitle:desc.title atIndex:i animated:YES];
        i++;
    }
    
    // add navigation image if set
    [self applyNavbarIconWithUrl:container.navbarIcon];
    
    // display the 1st one
    [self displayComponentWithDescription:firstComponentDesc];
    self.subMenu.selectedSegmentIndex = initial;
    
    [super applyContents];
}

#pragma mark - private methods

- (void)onButton:(id)theSubmenu
{
    SMContainer *container = (SMContainer *)self.model;
    
    NSInteger selectedIndex = [(SDSegmentedControl *)theSubmenu selectedSegmentIndex];
    SMComponentDescription *thedesc = [container.components objectAtIndex:selectedIndex];
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
    activeContentViewController = [SMComponentFactory subComponentWithDescription:description
                                                                 forNavigation:appDescription.navigationDescription];
    
    if (![activeContentViewController isKindOfClass:[SMBaseComponentViewController class]]) {
        return;
    }
    
    [(SMBaseComponentViewController *)activeContentViewController setComponentNavigationDelegate:self];
    
    // add controller's view to self.view
    float pullUp = 6.0;
    [activeContentViewController.view setFrame:CGRectMake(0,
                                                          CGRectGetHeight(self.subMenu.frame) - pullUp,
                                                          CGRectGetWidth(self.view.frame),
                                                          CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.subMenu.frame) + pullUp)];
    /*[activeContentViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin    |
     UIViewAutoresizingFlexibleHeight       |
     UIViewAutoresizingFlexibleLeftMargin   |
     UIViewAutoresizingFlexibleRightMargin  |
     UIViewAutoresizingFlexibleWidth];*/
    [activeContentViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    [activeContentViewController.view setBackgroundColor:[UIColor yellowColor]];
    [activeContentViewController.view setClipsToBounds:YES];
    
    [activeContentViewController.view setTag:subViewTag];
    
    [self.view addSubview:activeContentViewController.view];
    
    // send subview to back
    [self.subMenu removeFromSuperview];
    [self.view addSubview:self.subMenu];
    
    // disable its swipe functions, we override them here
    [self removeModuleByClass:[SMSwipeBackModule class]];
}

- (void)swipeToDeltaIndex:(NSInteger)deltaIndex
{
    SMContainer *container = (SMContainer *)self.model;
    
    NSInteger selectedIndex = [self.subMenu selectedSegmentIndex];
    NSInteger toSelectedIndex = selectedIndex + deltaIndex;
    if (toSelectedIndex >= 0 && toSelectedIndex < [container.components count]) {
        [self.subMenu setSelectedSegmentIndex:toSelectedIndex];
        SMComponentDescription *thedesc = [container.components objectAtIndex:toSelectedIndex];
        [self displayComponentWithDescription:thedesc];
    }
}

#pragma mark - swipe gestures

/*
- (void)onSwipeToLeft:(UIGestureRecognizer *)gestureRecognizer
{
    [self swipeToDeltaIndex:1];
}

- (void)onSwipeToRight:(UIGestureRecognizer *)gestureRecognizer
{
    NSInteger selectedIndex = [self.subMenu selectedSegmentIndex];
    if (selectedIndex == 0) {
        // if the far left sub-page is active, then go back to the previous vc
        [super onSwipeToRight:gestureRecognizer];
    } else {
        // we can display the subpage on the left
        [self swipeToDeltaIndex:-1];
    }
    
}
*/

#pragma mark - component navigation delegate

- (void)component:(SMBaseComponentViewController *)component
willShowViewController:(UIViewController *)controller
         animated:(BOOL)animated
{
    [self.navigationController pushViewController:controller animated:YES];
}

@end
