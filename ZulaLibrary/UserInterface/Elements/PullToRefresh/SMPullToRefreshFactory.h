//
//  SMPullToRefreshFactory.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/14/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMPullToRefresh.h"

typedef NS_ENUM(NSInteger, SMPullToRefreshType) {
    SMPullToRefreshDefault,
    SMPullToRefreshPlain,
    SMPullToRefreshRainbox
};

@interface SMPullToRefreshFactory : NSObject

+ (id<SMPullToRefresh>)pullToRefreshWithScrollView:(UIScrollView *)scrollView
                                          delegate:(id<SMPullToRefreshDelegate>)delegate;

+ (id<SMPullToRefresh>)pullToRefreshWithScrollView:(UIScrollView *)scrollView
                                          delegate:(id<SMPullToRefreshDelegate>)delegate
                                              type:(SMPullToRefreshType)type;

+ (id<SMPullToRefresh>)pullToRefreshWithScrollView:(UIScrollView *)scrollView
                                          delegate:(id<SMPullToRefreshDelegate>)delegate
                                              name:(NSString *)name;

@end
