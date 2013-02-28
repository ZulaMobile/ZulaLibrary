//
//  SMTabbedNavigationViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMTabbedNavigationViewController.h"
#import "SMNavigationApperanceManager.h"

@interface SMTabbedNavigationViewController ()

@end

@implementation SMTabbedNavigationViewController
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
    [self setViewControllers:components];
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

- (void)navigateComponent:(UIViewController *)toComponent fromComponent:(UIViewController *)fromComponent
{
    // change selected tab accordingly
    int i = 0;
    for (UIViewController *controller in self.viewControllers) {
        if (controller == toComponent) {
            [self setSelectedIndex:i];
        }
        i++;
    }
}

@end
