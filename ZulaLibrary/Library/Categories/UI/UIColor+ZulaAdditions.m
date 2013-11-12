//
//  UIColor+ZulaAdditions.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "UIColor+ZulaAdditions.h"

// Copyright 2010-2011 Sam Soffes
@interface NSString (ZulaPrivateAdditions)
- (NSUInteger)_hexValue;
@end

// Copyright 2010-2011 Sam Soffes
@implementation NSString (ZulaPrivateAdditions)
- (NSUInteger)_hexValue {
	NSUInteger result = 0;
	sscanf([self UTF8String], "%x", &result);
	return result;
}
@end

@implementation UIColor (ZulaAdditions)

- (UIColor *)lighterColor
{
    float h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:MIN(b * 1.3, 1.0)
                               alpha:a];
    return nil;
}

- (UIColor *)darkerColor
{
    float h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * 0.75
                               alpha:a];
    return nil;
}

- (BOOL)isBright
{
    const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
    
    if (CGColorGetNumberOfComponents(self.CGColor) == 2) {
        CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[0] * 587) + (componentColors[0] * 114)) / 1000;
        return (colorBrightness >= 0.5);
    } else if (CGColorGetNumberOfComponents(self.CGColor) == 4) {
        CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
        return (colorBrightness >= 0.5);
    } else {
        return raise(1);
    }
    
}

- (BOOL)isDark
{
    return ![self isBright];
}

- (BOOL)isWhite
{
    const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
    if (CGColorGetNumberOfComponents(self.CGColor) == 2) {
        return (componentColors[0] == 1 && componentColors[0] == 1 && componentColors[0] == 1);
    } else if (CGColorGetNumberOfComponents(self.CGColor) == 4) {
        return (componentColors[0] == 1 && componentColors[1] == 1 && componentColors[2] == 1);
    } else {
        return raise(1);
    }
}

- (BOOL)isBlack
{
    const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
    if (CGColorGetNumberOfComponents(self.CGColor) == 2) {
        return (componentColors[0] == 0 && componentColors[0] == 0 && componentColors[0] == 0);
    } else if (CGColorGetNumberOfComponents(self.CGColor) == 4) {
        return (componentColors[0] == 0 && componentColors[1] == 0 && componentColors[2] == 0);
    } else {
        raise(1);
    }
    
    return NO;
}

+ (UIColor *)colorWithHex:(NSString *)hex {
	// Remove `#` and `0x`
	if ([hex hasPrefix:@"#"]) {
		hex = [hex substringFromIndex:1];
	} else if ([hex hasPrefix:@"0x"]) {
		hex = [hex substringFromIndex:2];
	}
	
	// Invalid if not 3, 6, or 8 characters
	NSUInteger length = [hex length];
	if (length != 3 && length != 6 && length != 8) {
		return nil;
	}
	
	// Make the string 8 characters long for easier parsing
	if (length == 3) {
		NSString *r = [hex substringWithRange:NSMakeRange(0, 1)];
		NSString *g = [hex substringWithRange:NSMakeRange(1, 1)];
		NSString *b = [hex substringWithRange:NSMakeRange(2, 1)];
		hex = [NSString stringWithFormat:@"%@%@%@%@%@%@ff",
			   r, r, g, g, b, b];
	} else if (length == 6) {
		hex = [hex stringByAppendingString:@"ff"];
	}
	
	CGFloat red = [[hex substringWithRange:NSMakeRange(0, 2)] _hexValue] / 255.0f;
	CGFloat green = [[hex substringWithRange:NSMakeRange(2, 2)] _hexValue] / 255.0f;
	CGFloat blue = [[hex substringWithRange:NSMakeRange(4, 2)] _hexValue] / 255.0f;
	CGFloat alpha = [[hex substringWithRange:NSMakeRange(6, 2)] _hexValue] / 255.0f;
    
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


- (NSString *)hexValue {
	return [self hexValueWithAlpha:NO];
}


- (NSString *)hexValueWithAlpha:(BOOL)includeAlpha {
	CGColorRef color = self.CGColor;
	size_t count = CGColorGetNumberOfComponents(color);
	const CGFloat *components = CGColorGetComponents(color);
	
	static NSString *stringFormat = @"%02x%02x%02x";
	
	NSString *hex = nil;
	
	// Grayscale
	if (count == 2) {
		NSUInteger white = (NSUInteger)(components[0] * 255.0f);
		hex = [NSString stringWithFormat:stringFormat, white, white, white];
	}
	
	// RGB
	else if (count == 4) {
		hex = [NSString stringWithFormat:stringFormat, (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f), (NSUInteger)(components[2] * 255.0f)];
	}
	
	// Add alpha
	if (hex && includeAlpha) {
		hex = [hex stringByAppendingFormat:@"%02x", (NSUInteger)(self.alpha * 255.0f)];
	}
	
	// Unsupported color space
	return hex;
}


- (CGFloat)red {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
		return -1.0f;
	}
	CGFloat const *components = CGColorGetComponents(color);
	return components[0];
}


- (CGFloat)green {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
		return -1.0f;
	}
	CGFloat const *components = CGColorGetComponents(color);
	return components[1];
}


- (CGFloat)blue {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
		return -1.0f;
	}
	CGFloat const *components = CGColorGetComponents(color);
	return components[2];
}


- (CGFloat)alpha {
	return CGColorGetAlpha(self.CGColor);
}


@end
