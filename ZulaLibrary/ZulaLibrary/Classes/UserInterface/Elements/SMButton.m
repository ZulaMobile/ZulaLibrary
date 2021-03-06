//
//  SMButton.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMButton.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+ZulaAdditions.h"
#import "UIButton+SMAdditions.h"

@interface SMButton()

// adding glow effect on touch down/up
- (void)onTouchDown:(id)sender;
- (void)onTouchUp:(id)sender;
@end

@implementation SMButton
@synthesize imagePosition = _imagePosition;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Round button corners
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:5.0f];
        
        [self addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
    }
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	if (_imagePosition == SMButtonImagePositionLeft) {
		return;
	}
    
	CGRect imageFrame = self.imageView.frame;
	CGRect labelFrame = self.titleLabel.frame;
    
	labelFrame.origin.x = imageFrame.origin.x - self.imageEdgeInsets.left + self.imageEdgeInsets.right;
	imageFrame.origin.x += labelFrame.size.width;
    
	self.imageView.frame = imageFrame;
	self.titleLabel.frame = labelFrame;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    
    UIColor *darker = [backgroundColor darkerColor];
    UIColor *lighter = [backgroundColor lighterColor];
    
    // Draw a custom gradient
    CAGradientLayer *btnGradient = [CAGradientLayer layer];
    btnGradient.frame = self.bounds;
    btnGradient.colors = [NSArray arrayWithObjects:
                          (id)[lighter CGColor],
                          (id)[darker CGColor],
                          nil];
    [self.layer insertSublayer:btnGradient atIndex:0];
    
    // Change text color and attributes accordingly
    UIColor *titleColor;
    UIColor *shadowColor;
    CGSize shadowOffset;
    
    if ([darker isBright]) {
        // normal state
        titleColor = [UIColor darkTextColor];
        shadowColor = [UIColor whiteColor];
        shadowOffset = CGSizeMake(0, 1);
    } else {
        // normal state
        titleColor = [UIColor whiteColor];
        shadowColor = darker;
        shadowOffset = CGSizeMake(0, -2);
    }
    
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleShadowColor:shadowColor forState:UIControlStateNormal];
    //self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
    [self.titleLabel setShadowOffset:shadowOffset];
    [self setOpaque:YES];
    
    [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18]];
    
    // Apply a 1 pixel, dark border
    [self.layer setBorderWidth:1.0f];
    [self.layer setBorderColor:[darker CGColor]];
    
    // Apply initial glow
    //[self onTouchUp:self];
     
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)onTouchDown:(id)sender
{
    // add glow
    //UIColor *color = self.currentTitleColor;
    //[self addGlow:color];
    CGRect fr = self.frame;
    fr.origin.y += 1;
    fr.size.height -= 1;
    [self setFrame:fr];
}

- (void)onTouchUp:(id)sender
{
    //UIColor *color = self.currentTitleShadowColor;
    //[self addGlow:color];
    
    CGRect fr = self.frame;
    fr.origin.y -= 1;
    fr.size.height += 1;
    [self setFrame:fr];
}

@end
