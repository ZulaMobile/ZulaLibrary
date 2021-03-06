//
//  SMComponentModuleManager.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 31/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMComponentModuleManager.h"
#import "SMComponentModule.h"
#import "SMBaseComponentViewController.h"

#import "SMPullToRefreshModule.h"
#import "SMSwipeBackModule.h"
#import "SMProgressHUDModule.h"
#import "SMCustomAdvertisementModule.h"


@implementation SMComponentModuleManager

+ (NSArray *)modulesForComponent:(SMBaseComponentViewController *)component
{
    return @[[[SMProgressHUDModule alloc] initWithComponent:component],
             [[SMPullToRefreshModule alloc] initWithComponent:component],
             [[SMSwipeBackModule alloc] initWithComponent:component],
             [[SMCustomAdvertisementModule alloc] initWithComponent:component]
             ];
}

@end
