//
//  SMWebView.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/24/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMWebView.h"
#import "UIColor+SSToolkitAdditions.h"

@interface SMWebView()
- (void)appearanceForBackgroundHexColor:(NSString *)hexColor;
@end

@implementation SMWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
    }
    return self;
}

- (void)applyAppearances:(NSDictionary *)appearances
{
    [self appearanceForBackgroundHexColor:[appearances objectForKey:@"bg_color"]];
}


#pragma mark - appearances

- (void)appearanceForBackgroundHexColor:(NSString *)hexColor
{
    // default value
    if (!hexColor) {
        hexColor = @"clean";
    }
    
    if ([hexColor isEqualToString:@"clean"]) {
        [self setBackgroundColor:[UIColor clearColor]];
    } else {
        [self setBackgroundColor:[UIColor colorWithHex:hexColor]];
    }
}

@end
