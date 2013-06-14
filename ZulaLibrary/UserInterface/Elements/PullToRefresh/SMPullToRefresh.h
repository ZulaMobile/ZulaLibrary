//
//  SMPullToRefresh.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/14/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMPullToRefreshDelegate;

@protocol SMPullToRefresh <NSObject>

- (id) initWithScrollView:(UIScrollView *)scrollView delegate:(id <SMPullToRefreshDelegate>)delegate;
- (void) endRefresh;
- (void) startRefresh;

@end

@protocol SMPullToRefreshDelegate <NSObject>

- (void)pullToRefreshShouldRefresh:(id<SMPullToRefresh>)pullToRefresh;

@end