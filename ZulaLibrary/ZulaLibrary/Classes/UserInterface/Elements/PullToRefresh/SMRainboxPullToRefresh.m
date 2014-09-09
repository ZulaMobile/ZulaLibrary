//
//  SMRainboxPullToRefresh.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/14/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMRainboxPullToRefresh.h"
#import "ZulaLibrary.h"
#import "SMNotifications.h"


@implementation SMRainboxPullToRefresh
{
    BOOL _isRefreshing;
}
@synthesize delegate=_delegate;

- (id) initWithScrollView:(UIScrollView *)scrollView delegate:(id<SMPullToRefreshDelegate>)delegate {
    self = [super init];
    if (self) {
        _isRefreshing = NO;
        _delegate = delegate;
        _scrollView = scrollView;
        [_scrollView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
        
        _pullToRefresh = [[MSPullToRefreshController alloc] initWithScrollView:_scrollView delegate:self];
        
        //NSMutableArray *animationImages = [NSMutableArray arrayWithCapacity:19];
        //for (int i=1; i<20; i++)
        //    [animationImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading-%d.png",i]]];
        
        _rainbowTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zularesources.bundle/pull_to_refresh/gray/background"]];
        _rainbowTop.frame = CGRectMake(0, -_scrollView.frame.size.height, _scrollView.frame.size.width, scrollView.frame.size.height);
        //_rainbowTop.animationImages = animationImages;
        _rainbowTop.animationDuration = 2;
        [scrollView addSubview:_rainbowTop];
        
        _rainbowBot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zularesources.bundle/pull_to_refresh/gray/background"]];
        _rainbowBot.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _rainbowBot.frame = CGRectMake(0, _scrollView.frame.size.height, _scrollView.frame.size.width, scrollView.frame.size.height);
        //_rainbowBot.animationImages = animationImages;
        _rainbowBot.animationDuration = 2;
        [scrollView addSubview:_rainbowBot];
        
        
        
        _arrowTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zularesources.bundle/pull_to_refresh/default/big_arrow.png"]];
        _arrowTop.frame = CGRectMake(floorf((_rainbowTop.frame.size.width-_arrowTop.frame.size.width)/2), _rainbowTop.frame.size.height - _arrowTop.frame.size.height - 10 , _arrowTop.frame.size.width, _arrowTop.frame.size.height);
        [_rainbowTop addSubview:_arrowTop];
        
        _arrowBot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"big_arrow.png"]];
        _arrowBot.frame = CGRectMake(floorf((_rainbowBot.frame.size.width-_arrowBot.frame.size.width)/2), 10 , _arrowBot.frame.size.width, _arrowBot.frame.size.height);
        _arrowBot.transform  = CGAffineTransformMakeRotation(M_PI);
        [_rainbowBot addSubview:_arrowBot];
        
    }
    return self;
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"%@",NSStringFromCGSize(_scrollView.contentSize));
    CGFloat contentSizeArea = _scrollView.contentSize.width*_scrollView.contentSize.height;
    CGFloat frameArea = _scrollView.frame.size.width*_scrollView.frame.size.height;
    CGSize adjustedContentSize = contentSizeArea < frameArea ? _scrollView.frame.size : _scrollView.contentSize;
    _rainbowBot.frame = CGRectMake(0, adjustedContentSize.height, _scrollView.frame.size.width, _scrollView.frame.size.height);
}

- (void) endRefresh {
    [_pullToRefresh finishRefreshingDirection:MSRefreshDirectionTop animated:YES];
    [_pullToRefresh finishRefreshingDirection:MSRefreshDirectionBottom animated:YES];
    [_rainbowTop stopAnimating];
    [_rainbowBot stopAnimating];
    _arrowBot.hidden = NO;
    _arrowBot.transform  = CGAffineTransformMakeRotation(M_PI);
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
    return direction == MSRefreshDirectionTop || direction == MSRefreshDirectionBottom;
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
    _arrowBot.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller didDisengageRefreshDirection:(MSRefreshDirection)direction {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    _arrowTop.transform = CGAffineTransformIdentity;
    _arrowBot.transform  = CGAffineTransformMakeRotation(M_PI);
    [UIView commitAnimations];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kZulaNotificationPullToRefreshDidStopRefreshing
                                                        object:self];
}

- (void) pullToRefreshController:(MSPullToRefreshController *)controller didEngageRefreshDirection:(MSRefreshDirection)direction {
    _isRefreshing = YES;
    _arrowTop.hidden = YES;
    _arrowBot.hidden = YES;
    [_rainbowTop startAnimating];
    [_rainbowBot startAnimating];
    [_delegate pullToRefreshShouldRefresh:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kZulaNotificationPullToRefreshDidStartRefreshing
                                                        object:self];
}

@end
