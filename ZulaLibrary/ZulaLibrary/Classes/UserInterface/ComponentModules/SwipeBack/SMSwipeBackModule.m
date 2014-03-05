//
//  SMSwipeBackModule.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 31/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMSwipeBackModule.h"
#import "SMBaseComponentViewController.h"

@interface SMSwipeBackModule ()
- (void)onSwipeToLeft:(UIGestureRecognizer *)gestureRecognizer;
- (void)onSwipeToRight:(UIGestureRecognizer *)gestureRecognizer;
@end

@implementation SMSwipeBackModule
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
    }
    return self;
}

- (void)dealloc
{
    [self.component.view removeGestureRecognizer:swipeGestureToLeft];
    [self.component.view removeGestureRecognizer:swipeGestureToRight];
}

- (void)componentViewDidLoad
{
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

#pragma mark - swipe gestures

- (void)onSwipeToLeft:(UIGestureRecognizer *)gestureRecognizer
{
    
}

- (void)onSwipeToRight:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.component.navigationController) {
        [self.component.navigationController popViewControllerAnimated:YES];
    }
}

@end
