//
//  SMRainboxPullToRefresh.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/14/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSPullToRefreshController.h"
#import "SMPullToRefresh.h"

@protocol SMPullToRefreshDelegate;

@interface SMRainboxPullToRefresh : NSObject <SMPullToRefresh, MSPullToRefreshDelegate>
{
    UIImageView *_rainbowTop;
    UIImageView *_arrowTop;
    UIImageView *_rainbowBot;
    UIImageView *_arrowBot;
    
    UIScrollView *_scrollView;
    MSPullToRefreshController *_pullToRefresh;
}

@property (nonatomic, weak) id<SMPullToRefreshDelegate> delegate;

@end
