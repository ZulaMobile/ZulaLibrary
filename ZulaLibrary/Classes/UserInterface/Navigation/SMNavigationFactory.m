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
#import "SMSideNavigationViewController.h"

@implementation SMNavigationFactory

+(UIViewController<SMNavigation> *)navigationByType:(NSString *)type
{
    if ([type isEqualToString:@"tabbar"]) {
        return [SMTabbedNavigationViewController new];
    } else if ([type isEqualToString:@"navbar"]) {
        return [SMNavbarNavigationViewController new];
    } else if ([type isEqualToString:@"sidebar"]) {
        return [SMSideNavigationViewController new];
    }
    return nil;
}

@end
