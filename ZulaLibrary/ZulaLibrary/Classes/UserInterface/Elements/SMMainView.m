//
//  SMMainView.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/24/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMMainView.h"
#import "ZulaLibrary.h"
#import "Macros.h"

#import "UIColor+ZulaAdditions.h"
#import "SMImageView.h"

@interface SMMainView()
- (void)appearanceForBackgroundHexColor:(NSString *)hexColor;
@end

@implementation SMMainView
@synthesize backgroundImageUrl = _backgroundImageUrl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    }
    return self;
}

/**
 App wide appearances. Available options are
 */
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
    
    if ([hexColor isEqualToString:@"clean"] || [hexColor isEqualToString:@""]) {
        [self setBackgroundColor:[UIColor clearColor]];
    } else {
        [self setBackgroundColor:[UIColor colorWithHex:hexColor]];
    }
}

@end
