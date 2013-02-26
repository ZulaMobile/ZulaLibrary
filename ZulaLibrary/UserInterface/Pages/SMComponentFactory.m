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
        component = [[SMHomePageViewController alloc] initWithDescription:componentDescription];
    }
    return component;
}

@end
