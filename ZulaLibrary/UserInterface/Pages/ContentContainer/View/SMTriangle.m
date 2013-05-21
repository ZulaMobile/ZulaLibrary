//
//  Triangle.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMTriangle.h"

@implementation SMTriangle
@synthesize color;

- (id)initWithFrame:(CGRect)frame color:(UIColor *)theColor
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setColor:theColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // following is a triangle that looks down
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));  // bottom middle
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // top right
    CGContextClosePath(ctx);

    // folliwing triangle looks up
    /*
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMinY(rect));  // top middle
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom right
    CGContextClosePath(ctx);
    */
    
    if (!color) 
        color = [UIColor blackColor];
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillPath(ctx);
}

@end
