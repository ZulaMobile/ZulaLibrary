//
//  UIColor+ZulaAdditions.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//
//  Copyright of some methods are as follows:
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIColor (ZulaAdditions)

/**
 Creates and returns lighter version from the uicolor
 */
- (UIColor *)lighterColor;

/**
 Creates and returns darker version from the uicolor
 */
- (UIColor *)darkerColor;

/**
 Returns YES if the color is bright, No if it's dark
 */
- (BOOL)isBright;

/**
 Returns YES if the color is dark, No if it's bright
 */
- (BOOL)isDark;

/**
 Returns YES if the color is white
 */
- (BOOL)isWhite;

/**
 Returns YES if the color is black
 */
- (BOOL)isBlack;

/**
 Creates and returns an UIColor object containing a given value.
 
 @param hex The value for the new color. The `#` sign is not required.
 
 @return An UIColor object containing a value.
 
 You can specify hex values in the following formats: `rgb`, `rrggbb`, or `rrggbbaa`.
 
 The default alpha value is `1.0`.
 
 Copyright 2010-2011 Sam Soffes
 */
+ (UIColor *)colorWithHex:(NSString *)hex;

+ (UIColor *)colorWithHex:(NSString *)hex alpha:(float)alpha;

/**
 Returns the receiver's value as a hex string.
 
 @return The receiver's value as a hex string.
 
 The value will be `nil` if the color is in a color space other than Grayscale or RGB. The `#` sign is omitted. Alpha
 will be omitted.
 
 Copyright 2010-2011 Sam Soffes
 */
- (NSString *)hexValue;

/**
 Returns the receiver's value as a hex string.
 
 @param includeAlpha `YES` if alpha should be included. `NO` if it should not.
 
 @return The receiver's value as a hex string.
 
 The value will be `nil` if the color is in a color space other than Grayscale or RGB. The `#` sign is omitted. Alpha is
 included if `includeAlpha` is `YES`.
 
 Copyright 2010-2011 Sam Soffes
 */
- (NSString *)hexValueWithAlpha:(BOOL)includeAlpha;

/**
 The receiver's red component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 
 Copyright 2010-2011 Sam Soffes
 */
@property (nonatomic, assign, readonly) CGFloat red;

/**
 The receiver's green component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 
 Copyright 2010-2011 Sam Soffes
 */
@property (nonatomic, assign, readonly) CGFloat green;

/**
 The receiver's blue component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 
 Copyright 2010-2011 Sam Soffes
 */
@property (nonatomic, assign, readonly) CGFloat blue;

/**
 The receiver's alpha value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`, where `0.0` represents totally
 transparent and `1.0` represents totally opaque.
 
 Copyright 2010-2011 Sam Soffes
 */
@property (nonatomic, assign, readonly) CGFloat alpha;

@end
