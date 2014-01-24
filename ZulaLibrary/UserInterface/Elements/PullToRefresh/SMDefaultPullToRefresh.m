//
//  SMDefaultPullToRefresh.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/14/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMDefaultPullToRefresh.h"

@interface SMDefaultPullToRefresh ()
- (void)deviceOrientationDidChange:(NSNotification *)notification;
@end

@implementation SMDefaultPullToRefresh
{
    BOOL _isRefreshing;
}
@synthesize delegate=_delegate;

- (id) initWithScrollView:(UIScrollView *)scrollView delegate:(id <SMPullToRefreshDelegate>)delegate
{
    self = [super init];
    if (self) {
        _isRefreshing = NO;
        _delegate = delegate;
        _scrollView = scrollView;
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            if (isPad()) {
                [_scrollView setContentInset:UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f)];
                [_scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f)];
            } else {
                [_scrollView setContentInset:UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f)];
                [_scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f)];
            }
        }
        
        //[_scrollView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
        
        _pullToRefresh = [[MSPullToRefreshController alloc] initWithScrollView:_scrollView delegate:self];
        
        _background = [[UIView alloc] init];
        _background.frame = CGRectMake(0, -_scrollView.frame.size.height, _scrollView.frame.size.width, scrollView.frame.size.height);
        [scrollView addSubview:_background];
        
        _arrowTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zularesources.bundle/pull_to_refresh/default/big_arrow"]];
        _arrowTop.frame = CGRectMake((_background.frame.size.width - _arrowTop.frame.size.width)/2,
                                     _background.frame.size.height - _arrowTop.frame.size.height - 10 ,
                                     _arrowTop.frame.size.width, _arrowTop.frame.size.height);
        [_background addSubview:_arrowTop];
        
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_indicator setHidesWhenStopped:YES];
        _indicator.frame = CGRectMake(_arrowTop.frame.origin.x, _arrowTop.frame.origin.y, 16, 16);
        [_background addSubview:_indicator];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"%@",NSStringFromCGSize(_scrollView.contentSize));
    CGFloat contentSizeArea = _scrollView.contentSize.width*_scrollView.contentSize.height;
    CGFloat frameArea = _scrollView.frame.size.width*_scrollView.frame.size.height;
    CGSize adjustedContentSize = contentSizeArea < frameArea ? _scrollView.frame.size : _scrollView.contentSize;
    //_rainbowBot.frame = CGRectMake(0, adjustedContentSize.height, _scrollView.frame.size.width, _scrollView.frame.size.height);
}
 */

- (void) endRefresh {
    [_pullToRefresh finishRefreshingDirection:MSRefreshDirectionTop animated:YES];
    [_pullToRefresh finishRefreshingDirection:MSRefreshDirectionBottom animated:YES];
    [_indicator stopAnimating];
    _arrowTop.hidden = NO;
    _arrowTop.transform = CGAffineTransformIdentity;
    _isRefreshing = NO;
}

- (void) startRefresh {
    _isRefreshing = YES;
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
    return 30;
}

/*
 * inset that the direction retracts back to after refresh started
 */
- (CGFloat) pullToRefreshController:(MSPullToRefreshController *)controller refreshingInsetForDirection:(MSRefreshDirection)direction
{
    return 30;
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller canEngageRefreshDirection:(MSRefreshDirection)direction {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    _arrowTop.transform = CGAffineTransformMakeRotation(M_PI);
    [UIView commitAnimations];
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller didDisengageRefreshDirection:(MSRefreshDirection)direction {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    _arrowTop.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kZulaNotificationPullToRefreshDidStopRefreshing
                                                        object:self];
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller didEngageRefreshDirection:(MSRefreshDirection)direction {
    _isRefreshing = YES;
    _arrowTop.hidden = YES;
    [_indicator startAnimating];
    [_delegate pullToRefreshShouldRefresh:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kZulaNotificationPullToRefreshDidStartRefreshing
                                                        object:self];
}

#pragma mark - private methods

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGRect fr = [[UIScreen mainScreen] bounds];
    
    if (UIDeviceOrientationIsLandscape(orientation)) {
        _arrowTop.frame = CGRectMake((CGRectGetHeight(fr) - _arrowTop.frame.size.width)/2,
                                     _background.frame.size.height - _arrowTop.frame.size.height - 10 ,
                                     _arrowTop.frame.size.width, _arrowTop.frame.size.height);
    } else {
        _arrowTop.frame = CGRectMake((CGRectGetWidth(fr) - _arrowTop.frame.size.width)/2,
                                     _background.frame.size.height - _arrowTop.frame.size.height - 10 ,
                                     _arrowTop.frame.size.width, _arrowTop.frame.size.height);
    }
    _indicator.frame = CGRectMake(_arrowTop.frame.origin.x, _arrowTop.frame.origin.y, 16, 16);
}

@end
