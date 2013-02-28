//
//  SMNavbarNavigationViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMNavbarNavigationViewController.h"
#import "SMHomePageViewController.h"

@interface SMNavbarNavigationViewController ()

@end

@implementation SMNavbarNavigationViewController
{
    NSArray *components_;
}
@synthesize apperanceManager = appearanceManager_;

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
    UIViewController *firstComponent = [self.components objectAtIndex:0];
    [self presentViewController:firstComponent animated:NO completion:^{
        // nothing
    }];
}

#pragma mark - getters/setters

- (NSArray *)components
{
    return components_;
}

/**
 Set components and view controllers for the tabbarcontroller
 */
- (void)setComponents:(NSArray *)components
{
    components_ = components;
}

#pragma mark - methods

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
}

- (void)navigateComponent:(UIViewController *)toComponent fromComponent:(UIViewController *)fromComponent
{
    // the homepage component must have a navigation controller
    if (!fromComponent.navigationController) {
        DDLogError(@"Components set up incorrectly for navbarnavigation, Check componentFactory");
        return;
    }
    
    // the component that will be pushed must not be a navigation controller
    if (toComponent.navigationController) {
        DDLogError(@"toComponent set up incorrectly for navbarnavigation, Check componentFactory");
        return;
    }
    
    // push the navigation component
    [fromComponent.navigationController pushViewController:toComponent animated:YES];
}

#pragma mark - navigation controller delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[SMHomePageViewController class]]) {
        [viewController.navigationController setNavigationBarHidden:YES];
    } else {
        [viewController.navigationController setNavigationBarHidden:NO];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

@end
