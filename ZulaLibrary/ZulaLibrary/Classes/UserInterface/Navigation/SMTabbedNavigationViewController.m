//
//  SMTabbedNavigationViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMTabbedNavigationViewController.h"
#import "SMNavigationApperanceManager.h"
#import "SMAppDescription.h"
#import "SMComponentDescription.h"
#import "SMBaseComponentViewController.h"
#import "SMComponentFactory.h"

@interface SMTabbedNavigationViewController ()

@end

@implementation SMTabbedNavigationViewController
@synthesize apperanceManager = appearanceManager_, componentDescriptions=_componentDescriptions;

- (id)init
{
    self = [super init];
    if (self) {
        [self setApperanceManager:[SMNavigationApperanceManager appearanceManager]];
    }
    return self;
}

#pragma methods

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
    
    // set view controllers of the tabbar
    NSMutableArray *tmpViewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    UIViewController *ctrl = [self componentAtIndex:componentDescription.index];
    [tmpViewControllers addObject:ctrl];
    self.viewControllers = [NSArray arrayWithArray:tmpViewControllers];
}

/*
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
*/

- (SMBaseComponentViewController *)componentAtIndex:(NSInteger)index
{
    SMAppDescription *appDesc = [SMAppDescription sharedInstance];
    SMComponentDescription *compDesc = [appDesc.componentDescriptions objectAtIndex:index];
    
    if (!compDesc) {
        raise(1);
    }
    
    return (SMBaseComponentViewController *)[SMComponentFactory componentWithDescription:compDesc forNavigation:appDesc.navigationDescription];
}

- (SMBaseComponentViewController *)componentFromComponentDescription:(SMComponentDescription *)componentDescription
{
    SMAppDescription *appDesc = [SMAppDescription sharedInstance];
    return (SMBaseComponentViewController *)[SMComponentFactory componentWithDescription:componentDescription forNavigation:appDesc.navigationDescription];
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
