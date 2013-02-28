//
//  SMComponentFactory.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/26/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMComponentFactory.h"

// component imports
#import "SMHomePageViewController.h"
#import "SMContentViewController.h"

@implementation SMComponentFactory

+ (UIViewController *)componentWithDescription:(SMComponentDescription *)componentDescription
{
    UIViewController *component;
    if ([componentDescription.type isEqualToString:@"Content"]) {
        // create the component
        SMContentViewController *contentComponent = [[SMContentViewController alloc] initWithDescription:componentDescription];
        component = [[UINavigationController alloc] initWithRootViewController:contentComponent];
    } else if ([componentDescription.type isEqualToString:@"HomePage"]) {
        SMHomePageViewController *homePageComponent = [[SMHomePageViewController alloc] initWithDescription:componentDescription];
        component = [[UINavigationController alloc] initWithRootViewController:homePageComponent];
    }
    return component;
}

+ (UIViewController *)componentWithDescription:(SMComponentDescription *)componentDescription forNavigation:(SMNavigationDescription *)navigationDescription
{
    UIViewController *component;
    if ([componentDescription.type isEqualToString:@"Content"]) {
        // create the component
        component = [[SMContentViewController alloc] initWithDescription:componentDescription];
    } else if ([componentDescription.type isEqualToString:@"HomePage"]) {
        component = [[SMHomePageViewController alloc] initWithDescription:componentDescription];
    }
    
    if ([navigationDescription.type isEqualToString:@"tabbar"]) {
        return [[UINavigationController alloc] initWithRootViewController:component];
    } else if ([navigationDescription.type isEqualToString:@"navbar"]) {
        // only homepage must be navigation controller
        if ([componentDescription.type isEqualToString:@"HomePage"]) {
            return [[UINavigationController alloc] initWithRootViewController:component];
        }
        return component;
    }
    
    DDLogError(@"component `%@` is not supported by the navigation type: `%@`", componentDescription.type, navigationDescription.type);
    return nil;
}

@end
