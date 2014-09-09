//
//  SMTextView.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMTextView.h"
#import "SSDrawingUtilities.h"

@interface SMTextView()
- (void)appearanceForAlignment:(NSString *)alignment;
- (void)appearanceForBackgroundColorHex:(NSString *)colorHex;
- (void)appearanceForTextColor:(NSString *)hexColor;
- (void)appearanceForFontSize:(NSString *)fontSize fontFamily:(NSString *)fontFamily;
@end

@implementation SMTextView


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
        return;
    
    if ([alignment isEqualToString:@"left"]) {
        [self setTextAlignment:NSTextAlignmentLeft];
    } else if ([alignment isEqualToString:@"right"]) {
        [self setTextAlignment:NSTextAlignmentRight];
    } else if ([alignment isEqualToString:@"center"]) {
        [self setTextAlignment:NSTextAlignmentCenter];
    } else if ([alignment isEqualToString:@"justified"]) {
        [self setTextAlignment:NSTextAlignmentJustified];
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
    
    if ([hexColor isEqualToString:@"clean"] || [hexColor isEqualToString:@""]) {
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

#pragma mark - sstoolkit

#pragma mark - Accessors

@synthesize textEdgeInsets = _textEdgeInsets;
@synthesize clearButtonEdgeInsets = _clearButtonEdgeInsets;
@synthesize placeholderTextColor = _placeholderTextColor;

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
	_placeholderTextColor = placeholderTextColor;
	
	if (!self.text && self.placeholder) {
		[self setNeedsDisplay];
	}
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self _initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self _initialize];
    }
    return self;
}


#pragma mark - UITextField

- (CGRect)textRectForBounds:(CGRect)bounds {
	return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], _textEdgeInsets);
}


- (CGRect)editingRectForBounds:(CGRect)bounds {
	return [self textRectForBounds:bounds];
}


- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
	CGRect rect = [super clearButtonRectForBounds:bounds];
	rect = CGRectSetY(rect, rect.origin.y + _clearButtonEdgeInsets.top);
	return CGRectSetX(rect, rect.origin.x + _clearButtonEdgeInsets.right);
}


- (void)drawPlaceholderInRect:(CGRect)rect {
	if (!_placeholderTextColor) {
		[super drawPlaceholderInRect:rect];
		return;
	}
	
    [_placeholderTextColor setFill];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0
    [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByTruncatingTail alignment:self.textAlignment];
#else
    [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:UILineBreakModeTailTruncation alignment:self.textAlignment];
#endif
}


#pragma mark - Private

- (void)_initialize {
	_textEdgeInsets = UIEdgeInsetsZero;
	_clearButtonEdgeInsets = UIEdgeInsetsZero;
}



@end
