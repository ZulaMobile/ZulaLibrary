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
{
    // inline css to prepend the loaded html string
    NSString *_extraCss;
}
- (void)appearanceForBackgroundHexColor:(NSString *)hexColor;
- (void)appearanceForTextShadow:(NSString *)hexColor;
@end

@implementation SMWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        _extraCss = @"";
    }
    return self;
}

- (void)applyAppearances:(NSDictionary *)appearances
{
    [self appearanceForBackgroundHexColor:[appearances objectForKey:@"bg_color"]];
    [self appearanceForTextShadow:[appearances objectForKey:@"shadow_color"]];
}

- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL
{
    // prepend the extra style
    NSString *html = [NSString stringWithFormat:@"%@%@", _extraCss, string];
    [super loadHTMLString:html baseURL:baseURL];
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

// Text shadow is only available as CSS
- (void)appearanceForTextShadow:(NSString *)hexColor
{
    // default value
    if (!hexColor) {
        hexColor = @"clean";
    }
    
    if ([hexColor isEqualToString:@"clean"] || [hexColor isEqualToString:@""]) {
        
    } else {
        _extraCss = [NSString stringWithFormat:@"<style>div{ text-shadow: 0 1px 0 #%@; }</style>", hexColor];
    }
}

@end
