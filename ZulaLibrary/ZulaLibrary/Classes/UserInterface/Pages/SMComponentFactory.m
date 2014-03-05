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
#import "SMFeedViewController.h"

@implementation SMComponentFactory

+ (UIViewController *)componentWithDescription:(SMComponentDescription *)componentDescription
{
    UIViewController *component;
    
    // try to get build-in components
    if ([componentDescription.type isEqualToString:@"ContentComponent"]) {
        // create the component
        component = [[SMContentViewController alloc] initWithDescription:componentDescription];
    } else if ([componentDescription.type isEqualToString:@"HomePageComponent"]) {
        component = [[SMHomePageViewController alloc] initWithDescription:componentDescription];
    } else if ([componentDescription.type isEqualToString:@"ListComponent"]) {
        component = [[SMListViewController alloc] initWithDescription:componentDescription];
    } else if ([componentDescription.type isEqualToString:@"FeedComponent"]) {
        component = [[SMFeedViewController alloc] initWithDescription:componentDescription];
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
    
    // try to get app-specific components
    if (!component) {
        NSString *appInfoPath = [[NSBundle mainBundle] pathForResource:@"app" ofType:@"plist"];
        NSDictionary *appInfo = [NSDictionary dictionaryWithContentsOfFile:appInfoPath];
        NSArray *appComponents = [appInfo objectForKey:@"available_components"];
        for (NSString *componentTitle in appComponents) {
            if ([componentDescription.type isEqualToString:componentTitle]) {
                // by convention, component names are like this: [ComponentName]Component
                // we need to cut the Component out from it, and append "ViewController" at the end, and prepend the namespece "SM"
                NSString *componentName = [componentTitle stringByReplacingOccurrencesOfString:@"Component" withString:@""];
                componentName = [NSString stringWithFormat:@"SM%@ViewController", componentName];
                
                Class cls = NSClassFromString(componentName);
                if (cls) {
                    component = [[cls alloc] initWithDescription:componentDescription];
                    return component;
                }
            }
        }
    }
    
    if (!component) {
        DDLogError(@"Unknown component %@. Did you add additional components in app.plist? Perhaps you didn't link an external project contains that component.", componentDescription.type);
        assert(component);
        return nil;
    }
    
    return component;
}

+ (UIViewController *)componentWithDescription:(SMComponentDescription *)componentDescription
                                 forNavigation:(SMNavigationDescription *)navigationDescription
{
    UIViewController *component = [SMComponentFactory componentWithDescription:componentDescription];
    
    if (!component) {
        return nil;
    }
    
    if ([navigationDescription.type isEqualToString:@"tabbar"]) {
        return [[UINavigationController alloc] initWithRootViewController:component];
    } else if ([navigationDescription.type isEqualToString:@"navbar"]) {
        // only the 1st component (the component with index no:0) will be a navigation controller
        if (componentDescription.index == 0) return [[UINavigationController alloc] initWithRootViewController:component];
        
        // all other component are without navigation controller (because they will be pushed)
        return component;
    } else if ([navigationDescription.type isEqualToString:@"sidebar"]) {
        return [[UINavigationController alloc] initWithRootViewController:component];
    }
    
    DDLogError(@"component `%@` is not supported by the navigation type: `%@`", componentDescription.type, navigationDescription.type);
    return nil;
}

+ (UIViewController *)subComponentWithDescription:(SMComponentDescription *)componentDescription
                                    forNavigation:(SMNavigationDescription *)navigationDescription
{
    UIViewController *component = [SMComponentFactory componentWithDescription:componentDescription];
    
    if (!component) {
        return nil;
    }
    
    if ([navigationDescription.type isEqualToString:@"tabbar"]) {
        return component;
    } else if ([navigationDescription.type isEqualToString:@"navbar"]) {
        // only the 1st component (the component with index no:0) will be a navigation controller
        if (componentDescription.index == 0) return [[UINavigationController alloc] initWithRootViewController:component];
        
        // all other component are without navigation controller (because they will be pushed)
        return component;
    } else if ([navigationDescription.type isEqualToString:@"sidebar"]) {
        return component;
    }
    
    DDLogError(@"sub component `%@` is not supported by the navigation type: `%@`", componentDescription.type, navigationDescription.type);
    return nil;
}

@end
