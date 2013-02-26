//
//  SMNavbarNavigationViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMNavbarNavigationViewController.h"

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

#pragma getters/setters

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

#pragma methods

- (void)addChildComponent:(UIViewController *)component
{
    NSMutableArray *tmpComponents;
    if (self.components) {
        tmpComponents = [NSMutableArray arrayWithArray:self.components];
    } else {
        tmpComponents = [NSMutableArray array];
    }
    [tmpComponents addObject:component];
    [self setComponents:[NSArray arrayWithArray:tmpComponents]];
}

@end
