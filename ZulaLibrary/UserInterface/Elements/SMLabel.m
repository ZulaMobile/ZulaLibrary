//
//  SMLabel.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMLabel.h"

@interface SMLabel()
- (void)appearanceForAlignment:(NSString *)alignment;
- (void)appearanceForBackgroundColorHex:(NSString *)colorHex;
- (void)appearanceForTextColor:(NSString *)hexColor;
- (void)appearanceForFontSize:(NSString *)fontSize fontFamily:(NSString *)fontFamily;
@end

@implementation SMLabel

- (void)applyAppearances:(NSDictionary *)appearances
{
    // set appearances
    [self appearanceForAlignment:[appearances objectForKey:@"alignment"]];
    [self appearanceForBackgroundColorHex:[appearances objectForKey:@"bg_color"]];
    [self appearanceForTextColor:[appearances objectForKey:@"color"]];
    [self appearanceForFontSize:[appearances objectForKey:@"font_size"] fontFamily:[appearances objectForKey:@"font_family"]];
}

#pragma mark - appearance helpers

- (void)appearanceForAlignment:(NSString *)alignment
{
    // default value
    if (!alignment)
        alignment = @"left";
    
    if ([alignment isEqualToString:@"left"]) {
        [self setTextAlignment:NSTextAlignmentLeft];
    } else if ([alignment isEqualToString:@"right"]) {
        [self setTextAlignment:NSTextAlignmentRight];
    } else if ([alignment isEqualToString:@"center"]) {
        [self setTextAlignment:NSTextAlignmentCenter];
    } else if ([alignment isEqualToString:@"top"]) {
        [self setVerticalTextAlignment:SSLabelVerticalTextAlignmentTop];
    } else if ([alignment isEqualToString:@"bottom"]) {
        [self setVerticalTextAlignment:SSLabelVerticalTextAlignmentBottom];
    }
}

- (void)appearanceForBackgroundColorHex:(NSString *)hexColor
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

- (void)appearanceForTextColor:(NSString *)hexColor
{
    // default value
    if (!hexColor) {
        hexColor = @"333333";
    }
    
    if ([hexColor isEqualToString:@"clean"]) {
        [self setBackgroundColor:[UIColor clearColor]];
    } else {
        [self setTextColor:[UIColor colorWithHex:hexColor]];
    }
}

- (void)appearanceForFontSize:(NSString *)fontSize fontFamily:(NSString *)fontFamily
{
    // default value
    if (!fontSize) {
        fontSize = @"13";
    }
    if (!fontFamily) {
        fontFamily = @"Helvetica";
    }
    
    NSInteger fontSizeInteger = [fontSize integerValue];
    [self setFont:[UIFont fontWithName:fontFamily size:fontSizeInteger]];
}


@end
