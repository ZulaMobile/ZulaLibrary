//
//  SMScrollView.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMScrollView.h"

//scroll_color
@interface SMScrollView()
- (void)appearanceForScrollColor:(NSString *)scrollColor;
@end

@implementation SMScrollView

- (void)applyAppearances:(NSDictionary *)appearances
{
    [self appearanceForScrollColor:[appearances objectForKey:@"scroll_color"]];
}

- (void)appearanceForScrollColor:(NSString *)scrollColor
{
    if (!scrollColor) {
        return;
    }
    
    if ([scrollColor isEqualToString:@"white"]) {
        [self setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    }

    if ([scrollColor isEqualToString:@"black"]) {
        [self setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
    }
}

@end
