//
//  SMPlainPullToRefresh.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/26/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMPlainPullToRefresh.h"
#import "Macros.h"
#import "SMNotifications.h"

@implementation SMPlainPullToRefresh
{
    BOOL _isRefreshing;
    UIActivityIndicatorView *_indicator;
}
@synthesize delegate=_delegate;

- (id) initWithScrollView:(UIScrollView *)scrollView delegate:(id <SMPullToRefreshDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            if (isPad()) {
                [scrollView setContentInset:UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f)];
                [scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f)];
            } else {
                [scrollView setContentInset:UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f)];
                [scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f)];
            }
        }
        
        _isRefreshing = NO;
        _delegate = delegate;
        _scrollView = scrollView;
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_indicator hidesWhenStopped];
        
        
        //[_scrollView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
        
        _pullToRefresh = [[MSPullToRefreshController alloc] initWithScrollView:_scrollView delegate:self];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                           -40,
                                                           _scrollView.frame.size.width,
                                                           40)];
        [_label setBackgroundColor:[UIColor clearColor]];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0]];
        [_label setShadowColor:[UIColor whiteColor]];
        [_label setShadowOffset:CGSizeMake(0, 1)];
        [_label setText:NSLocalizedString(@"Pull Down to Refresh", nil)];
        [_scrollView addSubview:_label];
        
        [_indicator setFrame:CGRectMake(100, _label.frame.origin.y + 10, 20, 20)];
        [_scrollView addSubview:_indicator];
        
        _arrowTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zularesources.bundle/pull_to_refresh/default/big_arrow"]];
        _arrowTop.frame = CGRectMake(10.0f,
                                     - 40 + _arrowTop.frame.size.height + 2,
                                     _arrowTop.frame.size.width,
                                     _arrowTop.frame.size.height);
        [_scrollView addSubview:_arrowTop];
        
    }
    return self;
}

- (void) endRefresh {
    [_pullToRefresh finishRefreshingDirection:MSRefreshDirectionTop animated:YES];
    [_pullToRefresh finishRefreshingDirection:MSRefreshDirectionBottom animated:YES];
    [_label setText:NSLocalizedString(@"Pull Down to Refresh", nil)];
    [_indicator stopAnimating];
    _isRefreshing = NO;
    _arrowTop.hidden = NO;
    _arrowTop.transform = CGAffineTransformIdentity;
}

- (void) startRefresh {
    _isRefreshing = YES;
    _arrowTop.hidden = NO;
    [_pullToRefresh startRefreshingDirection:MSRefreshDirectionTop];
}

- (BOOL)isRefreshing
{
    return _isRefreshing;
}

#pragma mark - pull to refresh delegate

/*
 * asks the delegate which refresh directions it would like enabled
 */
- (BOOL) pullToRefreshController:(MSPullToRefreshController *) controller canRefreshInDirection:(MSRefreshDirection)direction
{
    return direction == MSRefreshDirectionTop;
}

/*
 * inset threshold to engage refresh
 */
- (CGFloat) pullToRefreshController:(MSPullToRefreshController *) controller refreshableInsetForDirection:(MSRefreshDirection) direction
{
    return 40;
}

/*
 * inset that the direction retracts back to after refresh started
 */
- (CGFloat) pullToRefreshController:(MSPullToRefreshController *)controller refreshingInsetForDirection:(MSRefreshDirection)direction
{
    return 40;
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller canEngageRefreshDirection:(MSRefreshDirection)direction {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [_indicator stopAnimating];
    [_label setText:NSLocalizedString(@"Release to Refresh", nil)];
    _arrowTop.transform = CGAffineTransformMakeRotation(M_PI);
    [UIView commitAnimations];
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller didDisengageRefreshDirection:(MSRefreshDirection)direction {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [_label setText:NSLocalizedString(@"Pull Down to Refresh", nil)];
    [_indicator stopAnimating];
    _arrowTop.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kZulaNotificationPullToRefreshDidStopRefreshing
                                                        object:self];
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller didEngageRefreshDirection:(MSRefreshDirection)direction {
    _isRefreshing = YES;
    [_label setText:NSLocalizedString(@"Loading...", nil)];
    [_indicator startAnimating];
    _arrowTop.hidden = YES;
    [_delegate pullToRefreshShouldRefresh:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kZulaNotificationPullToRefreshDidStartRefreshing
                                                        object:self];
}

@end
