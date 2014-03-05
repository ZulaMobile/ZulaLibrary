//
//  SMPullToRefreshComponentViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/14/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"
#import "SMPullToRefresh.h"

/**
 Base component that supports pull to refresh functionality.
 In order to activate pull to refresh, protected `pullToRefresh` member needs to be instantiated.
 When the content is loaded, [pullToRefresh endRefresh] needs to be called manually.
 */
@interface SMPullToRefreshComponentViewController : SMBaseComponentViewController <SMPullToRefreshDelegate>
{
    id<SMPullToRefresh> pullToRefresh;
}

@end
