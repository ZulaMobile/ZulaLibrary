//
//  SMGrayPullToRefresh.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 7/9/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSPullToRefreshController.h"
#import "SMPullToRefresh.h"

@interface SMGrayPullToRefresh : NSObject <SMPullToRefresh, MSPullToRefreshDelegate>
{
    UIImageView *_background;
    UIImageView *_arrowTop;
    UIActivityIndicatorView *_indicator;
    
    UIScrollView *_scrollView;
    MSPullToRefreshController *_pullToRefresh;
}

@property (nonatomic, weak) id<SMPullToRefreshDelegate> delegate;

@end
