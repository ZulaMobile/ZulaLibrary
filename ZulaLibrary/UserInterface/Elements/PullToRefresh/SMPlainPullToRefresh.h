//
//  SMPlainPullToRefresh.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/26/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSPullToRefreshController.h"
#import "SMPullToRefresh.h"

@interface SMPlainPullToRefresh : NSObject <SMPullToRefresh, MSPullToRefreshDelegate>
{
    UILabel *_label;
    
    UIImageView *_arrowTop;
    
    UIScrollView *_scrollView;
    MSPullToRefreshController *_pullToRefresh;
    
    
}

@property (nonatomic, weak) id<SMPullToRefreshDelegate> delegate;

@end
