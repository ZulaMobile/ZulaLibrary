//
//  SMPullToRefreshFactory.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/14/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMPullToRefresh.h"

@interface SMPullToRefreshFactory : NSObject

+ (id<SMPullToRefresh>)pullToRefreshWithScrollView:(UIScrollView *)scrollView delegate:(id <SMPullToRefreshDelegate>)delegate;

@end
