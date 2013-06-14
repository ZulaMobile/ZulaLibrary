//
//  SMPullToRefreshFactory.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/14/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMPullToRefreshFactory.h"
#import "SMRainboxPullToRefresh.h"

@implementation SMPullToRefreshFactory

+ (id<SMPullToRefresh>)pullToRefreshWithScrollView:(UIScrollView *)scrollView delegate:(id<SMPullToRefreshDelegate>)delegate
{
    return [[SMRainboxPullToRefresh alloc] initWithScrollView:scrollView delegate:delegate];
}

@end
