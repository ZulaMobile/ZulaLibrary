//
//  SMSwipeNavigationDelegate.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/27/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMSwipeComponentStrategy.h"
#import "SMBaseComponentViewController.h"

@interface SMSwipeComponentStrategy()
- (void)onSwipeToLeft:(UIGestureRecognizer *)gestureRecognizer;
- (void)onSwipeToRight:(UIGestureRecognizer *)gestureRecognizer;
@end

@implementation SMSwipeComponentStrategy
{
    // swipe gestures to switch between subpages
    UISwipeGestureRecognizer *swipeGestureToLeft;
    UISwipeGestureRecognizer *swipeGestureToRight;
}
@synthesize component;

- (id)initWithComponent:(SMBaseComponentViewController *)aComponent
{
    self = [super init];
    if (self) {
        self.component = aComponent;
    
        // swipe gestures
        swipeGestureToLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeToLeft:)];
        [swipeGestureToLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [swipeGestureToLeft setNumberOfTouchesRequired:1];
        [self.component.view addGestureRecognizer:swipeGestureToLeft];
        
        swipeGestureToRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeToRight:)];
        [swipeGestureToRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [swipeGestureToRight setNumberOfTouchesRequired:1];
        [self.component.view addGestureRecognizer:swipeGestureToRight];
        
    }
    return self;
}

- (void)dealloc
{
    [self.component.view removeGestureRecognizer:swipeGestureToLeft];
    [self.component.view removeGestureRecognizer:swipeGestureToRight];
}

#pragma mark - swipe gestures

- (void)onSwipeToLeft:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.delegate respondsToSelector:@selector(onSwipeToLeft:)]) {
        [self.delegate onSwipeToLeft:gestureRecognizer];
    }
}

- (void)onSwipeToRight:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.delegate respondsToSelector:@selector(onSwipeToRight:)]) {
        [self.delegate onSwipeToRight:gestureRecognizer];
    }
}

@end
