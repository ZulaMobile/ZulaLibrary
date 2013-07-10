//
//  SMSubMenuView.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/20/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMSubMenuView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+SSToolkitAdditions.h"
#import "UIColor+ZulaAdditions.h"
#import "SMTriangle.h"

#define triangleSize 10.0

@interface SMSubMenuView()
- (void)onButton:(id)sender;
- (void)activateTheButton:(UIButton *)button;
@end

@implementation SMSubMenuView
{
    // the background color that is set initially
    UIColor *bgColor;
    BOOL useStandardColoring;
}

@synthesize scrollView, activeButton, activeButtonIndicator;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        useStandardColoring = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [self.scrollView setContentSize:CGSizeMake(0, frame.size.height)];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        [self.scrollView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)changeBackgroundColor:(UIColor *)backgroundColor
{
    bgColor = (useStandardColoring) ? [UIColor colorWithHex:@"CCCCCC"] : backgroundColor;
    UIColor *lighter = [bgColor lighterColor];
    
    // indicator
    self.activeButtonIndicator = [[SMTriangle alloc] initWithFrame:
                                  CGRectMake(0, CGRectGetHeight(self.frame) - triangleSize - 4, triangleSize + 8, triangleSize)
                                                             color:bgColor];
    [(SMTriangle *)self.activeButtonIndicator setColor:bgColor];
    [self.activeButtonIndicator setBackgroundColor:[UIColor clearColor]];
    
    // background
    UIView *background = [[UIView alloc] initWithFrame:
                          CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - triangleSize - 4)];
    [background setBackgroundColor:lighter];
    if (useStandardColoring) {
        [background.layer setShadowColor:[UIColor blackColor].CGColor];
        background.layer.shadowOffset = CGSizeMake(0, 2);
        background.layer.shadowRadius = 5;
        background.layer.shadowOpacity = 0.1;
    } else {
        [background.layer setShadowColor:[UIColor whiteColor].CGColor];
        background.layer.shadowOffset = CGSizeMake(0, 5);
        background.layer.shadowRadius = 5;
        background.layer.shadowOpacity = 0.8;
    }
    
    background.layer.masksToBounds = NO;
    [background setClipsToBounds:NO];
    
    // Draw a custom gradient
    CAGradientLayer *btnGradient = [CAGradientLayer layer];
    btnGradient.frame = background.bounds;
    btnGradient.colors = [NSArray arrayWithObjects:
                          (id)[lighter CGColor],
                          (id)[bgColor CGColor],
                          nil];
    [self.layer insertSublayer:btnGradient atIndex:0];
    
    // add them to view
    [self addSubview:background];
    [self sendSubviewToBack:background];
    [self.scrollView addSubview:self.activeButtonIndicator];
}

- (void)addButtonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    float padding = 10.0;
    NSString *fontName = @"HelveticaNeue-Bold";
    float fontSize = 13.0;
    
    CGSize contentSize = self.scrollView.contentSize;
    CGSize titleSize = [title sizeWithFont:[UIFont fontWithName:fontName size:fontSize]
                         constrainedToSize:CGSizeMake(320, self.frame.size.height)
                             lineBreakMode:NSLineBreakByTruncatingTail];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTag:tag];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn.titleLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    
    // set button color to proporional to the background
    if (useStandardColoring) {
        UIColor *btnColor = [bgColor darkerColor];
        [btn setTitleColor:btnColor forState:UIControlStateNormal];
        [btn setTitleShadowColor:[UIColor colorWithHex:@"FFFFFF"] forState:UIControlStateNormal];
    } else {
        [btn setTitleColor:[UIColor colorWithHex:@"EFEFEF"] forState:UIControlStateNormal];
        [btn setTitleShadowColor:[UIColor colorWithHex:@"000000"] forState:UIControlStateNormal];
    }
    
    [btn.titleLabel setShadowOffset:CGSizeMake(0, 1)];
    //[btn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
    //[btn.layer setCornerRadius:10.0];
    [btn setFrame:CGRectMake(scrollView.contentSize.width + padding,
                             padding / 2,
                             titleSize.width + padding * 2,
                             self.frame.size.height - padding - triangleSize)];
    [btn addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // @todo: apply appearances
    
    // activate the button if this is the 1st one
    if (self.scrollView.contentSize.width == 0) {
        [self activateTheButton:btn];
    }
    
    [self.scrollView addSubview:btn];
    [self.scrollView setContentSize:CGSizeMake(contentSize.width + btn.frame.size.width + padding * 2, self.frame.size.height)];
}

- (UIButton *)buttonWithTag:(NSInteger)tag
{
    return (UIButton *)[self.scrollView viewWithTag:tag];
}

- (void)applyAppearances:(NSDictionary *)appearances
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - private methods

- (void)onButton:(id)sender
{
    [self setActiveButton:sender];
    [self activateTheButton:sender];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)activateTheButton:(UIButton *)button
{
    // normalize all buttons
    for (UIView *btn in self.scrollView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            //[btn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
        }
    }
    
    // highlight current one
    //[button setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.8]];
    
    // create the indicator
    CGRect indicatorFrame = self.activeButtonIndicator.frame;
    indicatorFrame.origin.x = button.frame.origin.x + button.frame.size.width / 2 - indicatorFrame.size.width / 2;
 
    // animate the indicator movement
    [UIView animateWithDuration:0.3 animations:^{
        [self.activeButtonIndicator setFrame:indicatorFrame];
        
    }];
    
    CGRect toVisible;
    if (button.frame.origin.x - self.scrollView.contentOffset.x >= self.frame.size.width / 2) {
        toVisible = CGRectMake(button.frame.origin.x, button.frame.origin.y, CGRectGetWidth(button.frame) + 60, CGRectGetHeight(button.frame));
    } else {
        toVisible = CGRectMake(button.frame.origin.x - 60, button.frame.origin.y, CGRectGetWidth(button.frame), CGRectGetHeight(button.frame));
    }
    
    [self.scrollView scrollRectToVisible:toVisible animated:YES];
}

@end
