//
//  SMDefaultPullToRefresh.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/14/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSPullToRefreshController.h"
#import "SMPullToRefresh.h"

@interface SMDefaultPullToRefresh : NSObject <SMPullToRefresh, MSPullToRefreshDelegate>
{
    UIImageView *_background;
    UIImageView *_arrowTop;
    UIActivityIndicatorView *_indicator;
    
    UIScrollView *_scrollView;
    MSPullToRefreshController *_pullToRefresh;
    
    id<SMPullToRefreshDelegate> _delegate;
}

@end