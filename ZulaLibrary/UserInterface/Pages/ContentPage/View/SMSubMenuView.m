//
//  SMSubMenuView.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/20/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMSubMenuView.h"
#import <QuartzCore/QuartzCore.h>

@interface SMSubMenuView()
- (void)onButton:(id)sender;
@end

@implementation SMSubMenuView

@synthesize scrollView, activeButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [self.scrollView setContentSize:CGSizeMake(0, frame.size.height)];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)addButtonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    float padding = 10.0;
    NSString *fontName = @"HelveticaNeue-Medium";
    float fontSize = 13.0;
    
    CGSize contentSize = self.scrollView.contentSize;
    CGSize titleSize = [title sizeWithFont:[UIFont fontWithName:fontName size:fontSize]
                         constrainedToSize:CGSizeMake(320, self.frame.size.height)
                             lineBreakMode:NSLineBreakByTruncatingTail];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:fontName size:fontSize]];
    [btn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
    [btn.layer setCornerRadius:10.0];
    [btn setFrame:CGRectMake(scrollView.contentSize.width + padding,
                             padding / 2,
                             titleSize.width + padding * 2,
                             self.frame.size.height - padding)];
    [btn addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // @todo: apply appearances
    
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
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
