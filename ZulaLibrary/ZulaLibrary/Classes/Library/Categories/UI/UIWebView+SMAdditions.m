//
//  UIWebView+SMAdditions.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "UIWebView+SMAdditions.h"

@implementation UIWebView (SMAdditions)

- (void)disableScrollBounce
{
    for (id subview in self.subviews)
        if ([[subview class] isSubclassOfClass: [UIScrollView class]])
            ((UIScrollView *)subview).bounces = NO;
}

@end
