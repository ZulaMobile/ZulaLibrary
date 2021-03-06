//
//  SMNavbarNavigationViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMNavbarNavigationViewController.h"
#import "SMHomePageViewController.h"
#import "SMBaseComponentViewController.h"
#import "SMAppDescription.h"
#import "SMComponentDescription.h"
#import "SMComponentFactory.h"
#import "SMNavigationApperanceManager.h"
#import "SMBaseComponentViewController.h"

@interface SMNavbarNavigationViewController ()

@end

@implementation SMNavbarNavigationViewController
@synthesize apperanceManager = appearanceManager_, componentDescriptions=_componentDescriptions;

- (id)init
{
    self = [super init];
    if (self) {
        [self setApperanceManager:[SMNavigationApperanceManager appearanceManager]];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    // set the 1st component as the root controller
    UIViewController *firstComponent = [self componentAtIndex:0];
    [self presentViewController:firstComponent animated:NO completion:^{
        // fade in the view
        [firstComponent.view setAlpha:0];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.5];
        [firstComponent.view setAlpha:1];
        [UIView commitAnimations];
    }];
    
}

#pragma mark - methods

- (void)addChildComponentDescription:(SMComponentDescription *)componentDescription
{
    // add component to the self.components
    NSMutableArray *tmpComponents;
    if (self.componentDescriptions) {
        tmpComponents = [NSMutableArray arrayWithArray:self.componentDescriptions];
    } else {
        tmpComponents = [NSMutableArray array];
    }
    [tmpComponents addObject:componentDescription];
    [self setComponentDescriptions:[NSArray arrayWithArray:tmpComponents]];
 
    // if it's homepage component, add the navigation delegate to this class
    //if ([component isKindOfClass:[UINavigationController class]]) {
    //    [(UINavigationController *)component setDelegate:self];
    //}
}


- (SMBaseComponentViewController *)componentAtIndex:(NSInteger)index
{
    SMComponentDescription *compDesc = [self.componentDescriptions objectAtIndex:index];
    
    if (!compDesc) {
        raise(1);
    }
 
    SMAppDescription *appDesc = [SMAppDescription sharedInstance];
    return (SMBaseComponentViewController *)[SMComponentFactory componentWithDescription:compDesc forNavigation:appDesc.navigationDescription];
}

- (SMBaseComponentViewController *)componentFromComponentDescription:(SMComponentDescription *)componentDescription
{
    SMAppDescription *appDesc = [SMAppDescription sharedInstance];
    return (SMBaseComponentViewController *)[SMComponentFactory componentWithDescription:componentDescription forNavigation:appDesc.navigationDescription];
}

/*
- (void)addChildComponent:(UIViewController *)component
{
    // add component to the self.components
    NSMutableArray *tmpComponents;
    if (self.components) {
        tmpComponents = [NSMutableArray arrayWithArray:self.components];
    } else {
        tmpComponents = [NSMutableArray array];
    }
    [tmpComponents addObject:component];
    [self setComponents:[NSArray arrayWithArray:tmpComponents]];
    
    // if it's homepage component, add the navigation delegate to this class
    if ([component isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)component setDelegate:self];
    }
}*/

- (void)navigateComponent:(UIViewController *)toComponent fromComponent:(UIViewController *)fromComponent
{
    // the homepage component must have a navigation controller
    if (!fromComponent.navigationController) {
        NSLog(@"Components set up incorrectly for navbarnavigation, Check componentFactory");
        return;
    }
    
    // the component that will be pushed must not be a navigation controller
    if (toComponent.navigationController) {
        NSLog(@"toComponent set up incorrectly for navbarnavigation, Check componentFactory");
        return;
    }
    
    // push the navigation component
    [fromComponent.navigationController pushViewController:toComponent animated:YES];
}

#pragma mark - navigation controller delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    /*
    if ([viewController isKindOfClass:[SMHomePageViewController class]]) {
        [viewController.navigationController setNavigationBarHidden:YES];
    } else {
        [viewController.navigationController setNavigationBarHidden:NO];
    }*/
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

@end
