//
//  SMPullToRefreshComponentViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/14/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMPullToRefreshComponentViewController.h"

@interface SMPullToRefreshComponentViewController ()

@end

@implementation SMPullToRefreshComponentViewController

#pragma mark - pull to refresh delegfate

- (void)pullToRefreshShouldRefresh:(id<SMPullToRefresh>)thePullToRefresh
{
    [self fetchContents];
}

@end
