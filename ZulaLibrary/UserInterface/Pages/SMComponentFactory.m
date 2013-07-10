//
//  SMComponentFactory.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/26/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMComponentFactory.h"
#import <DDLog.h>

// component imports
#import "SMHomePageViewController.h"
#import "SMContentViewController.h"
#import "SMListViewController.h"
#import "SMContentContainerViewController.h"
#import "SMProductDetailViewController.h"
#import "SMContactViewController.h"
#import "SMImageGalleryViewController.h"
#import "SMContainerViewController.h"
#import "SMWebViewController.h"
#import "SMVideoGalleryViewController.h"

@implementation SMComponentFactory

+ (UIViewController *)componentWithDescription:(SMComponentDescription *)componentDescription
{
    UIViewController *component;
    if ([componentDescription.type isEqualToString:@"ContentComponent"]) {
        // create the component
        component = [[SMContentViewController alloc] initWithDescription:componentDescription];
    } else if ([componentDescription.type isEqualToString:@"HomePageComponent"]) {
        component = [[SMHomePageViewController alloc] initWithDescription:componentDescription];
    } else if ([componentDescription.type isEqualToString:@"ListComponent"]) {
        component = [[SMListViewController alloc] initWithDescription:componentDescription];
    } else if ([componentDescription.type isEqualToString:@"ContentContainerComponent"]) {
        component = [[SMContentContainerViewController alloc] initWithDescription:componentDescription];
    } else if ([componentDescription.type isEqualToString:@"ProductDetailComponent"]) {
        component = [[SMProductDetailViewController alloc] initWithDescription:componentDescription];
    } else if ([componentDescription.type isEqualToString:@"ContactComponent"]) {
        component = [[SMContactViewController alloc] initWithDescription:componentDescription];
    } else if ([componentDescription.type isEqualToString:@"ImageGalleryComponent"]) {
        component = [[SMImageGalleryViewController alloc] initWithDescription:componentDescription];
    } else if ([componentDescription.type isEqualToString:@"ContainerComponent"]) {
        component = [[SMContainerViewController alloc] initWithDescription:componentDescription];
    } else if ([componentDescription.type isEqualToString:@"WebComponent"]) {
        component = [[SMWebViewController alloc] initWithDescription:componentDescription];
    } else if ([componentDescription.type isEqualToString:@"VideoGalleryComponent"]) {
        component = [[SMVideoGalleryViewController alloc] initWithDescription:componentDescription];
    }
    
    if (!component) {
        DDLogError(@"unknown component %@", componentDescription.type);
        assert(component);
        return nil;
    }
    
    return component;
}

+ (UIViewController *)componentWithDescription:(SMComponentDescription *)componentDescription forNavigation:(SMNavigationDescription *)navigationDescription
{
    UIViewController *component = [SMComponentFactory componentWithDescription:componentDescription];
    
    if (!component) {
        return nil;
    }
    
    if ([navigationDescription.type isEqualToString:@"tabbar"]) {
        return [[UINavigationController alloc] initWithRootViewController:component];
    } else if ([navigationDescription.type isEqualToString:@"navbar"]) {
        // only homepage must be navigation controller
        if ([componentDescription.type isEqualToString:@"HomePageComponent"]) {
            return [[UINavigationController alloc] initWithRootViewController:component];
        }
        return component;
    }
    
    DDLogError(@"component `%@` is not supported by the navigation type: `%@`", componentDescription.type, navigationDescription.type);
    return nil;
}

@end
