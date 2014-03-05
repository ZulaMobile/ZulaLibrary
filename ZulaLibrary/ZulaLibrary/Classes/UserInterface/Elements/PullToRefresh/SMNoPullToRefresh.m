//
//  SMNoPullToRefresh.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 14/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMNoPullToRefresh.h"

@implementation SMNoPullToRefresh

- (id)initWithScrollView:(UIScrollView *)scrollView delegate:(id <SMPullToRefreshDelegate>)delegate
{
    //CGFloat topLayoutGuide = self.topLayoutGuide.length;
    //topLayoutGuide += self.tabBarController.navigationController.navigationBar.frame.size.height;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        if (isPad()) {
            [scrollView setContentInset:UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f)];
            [scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f)];
        } else {
            [scrollView setContentInset:UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f)];
            [scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f)];
        }
    }
    
    return [super init];
}

- (void) endRefresh
{
    
}

- (void) startRefresh
{
    
}

- (BOOL) isRefreshing
{
    return NO;
}

#pragma mark - ms pull to refresh

- (BOOL) pullToRefreshController:(MSPullToRefreshController *) controller canRefreshInDirection:(MSRefreshDirection)direction
{
    return NO;
}

/*
 * inset threshold to engage refresh
 */
- (CGFloat) pullToRefreshController:(MSPullToRefreshController *) controller refreshableInsetForDirection:(MSRefreshDirection) direction
{
    return 0.0f;
}

/*
 * inset that the direction retracts back to after refresh started
 */
- (CGFloat) pullToRefreshController:(MSPullToRefreshController *)controller refreshingInsetForDirection:(MSRefreshDirection)direction
{
    return 0.0f;
}

@end
