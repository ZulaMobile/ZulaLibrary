//
//  UIColor+ZulaAdditions.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "UIColor+ZulaAdditions.h"

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
    
    CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
    
    return (colorBrightness >= 0.5);
}

- (BOOL)isDark
{
    return ![self isBright];
}

@end
