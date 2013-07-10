//
//  SMSwipeNavigationDelegate.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/27/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMComponentDelegate.h"

@protocol SMSwipeComponentStrategyDelegate;

/**
 This delegate adds swiping gestures for UINavigationController
 
 These gestures are implemented for each component to achieve a consistent UX
 Standard behavior is to go back to the previous page if there is a navigation controller
 and the page is top on the stack
 */
@interface SMSwipeComponentStrategy : NSObject <SMComponentStrategy>

@property (nonatomic, weak) id<SMSwipeComponentStrategyDelegate> delegate;

@end

@protocol SMSwipeComponentStrategyDelegate <NSObject>

@optional
- (void)onSwipeToLeft:(UIGestureRecognizer *)gestureRecognizer;
- (void)onSwipeToRight:(UIGestureRecognizer *)gestureRecognizer;

@end
