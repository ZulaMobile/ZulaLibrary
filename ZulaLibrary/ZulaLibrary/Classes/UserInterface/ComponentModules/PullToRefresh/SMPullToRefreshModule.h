//
//  SMPullToRefreshModule.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 31/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMComponentModule.h"
#import "SMPullToRefresh.h"


/**
 In order to activate pull to refresh, protected `pullToRefresh` member needs to be instantiated.
 When the content is loaded, [pullToRefresh endRefresh] needs to be called manually.
 */
@interface SMPullToRefreshModule : NSObject <SMComponentModule, SMPullToRefreshDelegate>
{
    id<SMPullToRefresh> pullToRefresh;
}

@end
