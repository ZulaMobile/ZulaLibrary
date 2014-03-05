//
//  SMPullToRefreshFactory.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/14/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMPullToRefreshFactory.h"
#import "SMRainboxPullToRefresh.h"
#import "SMDefaultPullToRefresh.h"
#import "SMPlainPullToRefresh.h"
#import "SMNoPullToRefresh.h"

@implementation SMPullToRefreshFactory

+ (id<SMPullToRefresh>)pullToRefreshWithScrollView:(UIScrollView *)scrollView
                                          delegate:(id<SMPullToRefreshDelegate>)delegate
{
    return [SMPullToRefreshFactory pullToRefreshWithScrollView:scrollView delegate:delegate type:SMPullToRefreshDefault];
}

+ (id<SMPullToRefresh>)pullToRefreshWithScrollView:(UIScrollView *)scrollView
                                          delegate:(id<SMPullToRefreshDelegate>)delegate
                                              type:(SMPullToRefreshType)type
{
    if (type == SMPullToRefreshPlain) {
        return [[SMPlainPullToRefresh alloc] initWithScrollView:scrollView delegate:delegate];
    } else if (type == SMPullToRefreshRainbox) {
        return [[SMRainboxPullToRefresh alloc] initWithScrollView:scrollView delegate:delegate];
    } else {
        return [[SMDefaultPullToRefresh alloc] initWithScrollView:scrollView delegate:delegate];
    }
    
}

+ (id<SMPullToRefresh>)pullToRefreshWithScrollView:(UIScrollView *)scrollView
                                          delegate:(id<SMPullToRefreshDelegate>)delegate
                                              name:(NSString *)name
{
    SMPullToRefreshType type;
    if ([name isEqualToString:@"plain"]) {
        type = SMPullToRefreshPlain;
    } else if ([name isEqualToString:@"rainbow"]) {
        type = SMPullToRefreshRainbox;
    } else {
        type = SMPullToRefreshDefault;
    }
    
    return [SMPullToRefreshFactory pullToRefreshWithScrollView:scrollView
                                                      delegate:delegate
                                                          type:type];
}

@end
