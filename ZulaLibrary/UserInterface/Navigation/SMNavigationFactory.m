//
//  SMNavigationFactory.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/26/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMNavigationFactory.h"
#import "SMTabbedNavigationViewController.h"
#import "SMNavbarNavigationViewController.h"

@implementation SMNavigationFactory

+(UIViewController<SMNavigation> *)navigationByType:(NSString *)type
{
    if ([type isEqualToString:@"tabbar"]) {
        return [[SMTabbedNavigationViewController alloc] init];
    } else if ([type isEqualToString:@"navbar"]) {
        return [[SMNavbarNavigationViewController alloc] init];
    }
    return nil;
}

@end
