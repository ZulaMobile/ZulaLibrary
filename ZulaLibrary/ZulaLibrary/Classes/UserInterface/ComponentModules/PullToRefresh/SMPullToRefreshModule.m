//
//  SMPullToRefreshModule.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 31/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMPullToRefreshModule.h"
#import "SMBaseComponentViewController.h"
#import "SMPullToRefreshFactory.h"
#import "SMComponentDescription.h"


@implementation SMPullToRefreshModule
@synthesize component;

- (id)initWithComponent:(SMBaseComponentViewController *)aComponent
{
    self = [super init];
    if (self) {
        self.component = aComponent;
    }
    return self;
}

#pragma mark - optional methods 

- (void)componentViewDidLoad
{
    // the scrollview must be the second child view after the background image
    UIView *view = [[self.component.view subviews] objectAtIndex:1];
    if (![view isKindOfClass:[UIScrollView class]]) {
        // there is no scroll view to attach pull to refresh
        return;
    }
    
    NSString *pullToRefreshType = [self.component.componentDesciption.appearance objectForKey:@"pull_to_refresh_type"];
    pullToRefresh = [SMPullToRefreshFactory pullToRefreshWithScrollView:(UIScrollView *)view
                                                               delegate:self
                                                                   name:pullToRefreshType];
}

- (BOOL)componentShouldFetchContents
{
    // if data is already set and not deliberately refreshing contents, so no need to fetch contents
    if (![pullToRefresh isRefreshing] && self.component.model) {
        [self.component applyContents];
        return NO;
    }
    
    return YES;
}

- (void)componentWillFetchContents
{
    // start preloader
    //if (![pullToRefresh isRefreshing])
    //    [SMProgressHUD show];
}

- (void)componentDidFetchContent:(SMModel *)model
{
    [pullToRefresh endRefresh];
}

#pragma mark - pull to refresh delegfate

- (void)pullToRefreshShouldRefresh:(id<SMPullToRefresh>)thePullToRefresh
{
    // fetch the contents
    if ([self.component shouldFetchContents]) {
        [self.component fetchContents];
    }
}

@end
