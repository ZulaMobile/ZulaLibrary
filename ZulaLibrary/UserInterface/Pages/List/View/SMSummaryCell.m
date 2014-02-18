//
//  SMSummaryCell.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 27/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMSummaryCell.h"

@implementation SMSummaryCell
{
    float padding;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        padding = 10.0f;
        
        self.background = [UIView new];
        self.background.backgroundColor = [UIColor whiteColor];
        
        self.title = [UILabel new];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textColor = [UIColor darkTextColor];
        self.title.font = [UIFont boldSystemFontOfSize:13.0f];
        
        self.image = [UIImageView new];
        self.image.backgroundColor = [UIColor colorWithHue:1 saturation:0.5 brightness:0.5 alpha:0.5];
        self.image.contentMode = UIViewContentModeScaleAspectFill;
        self.image.clipsToBounds = YES;
        
        self.summary = [UILabel new];
        self.summary.backgroundColor = [UIColor clearColor];
        self.summary.textColor = [UIColor darkTextColor];
        self.summary.numberOfLines = 4;
        self.summary.font = [UIFont systemFontOfSize:13.0f];
        self.summary.lineBreakMode = NSLineBreakByWordWrapping;
        
        self.backgroundColor = [UIColor clearColor];
                      
        [self.background addSubview:self.image];
        [self.background addSubview:self.title];
        [self.background addSubview:self.summary];
        
        [self addSubview:self.background];
        
        [self activateNoImageView];
    }
    return self;
}

- (void)applyAppearances:(NSDictionary *)appearances
{
    
}

- (void)activateNoImageView
{
    self.background.frame = CGRectMake(padding, padding,
                                       320.0f - padding * 2,
                                       30.0 + 100.0f + padding * 2);
    
    float innerPadding = 10.0f;
    self.title.frame = CGRectMake(innerPadding, innerPadding, CGRectGetWidth(self.background.frame) - innerPadding * 2, 30.0f);
    self.summary.frame = CGRectMake(innerPadding, CGRectGetHeight(self.title.frame),
                                    CGRectGetWidth(self.background.frame)  - innerPadding * 2, 100.0f);
    self.image.hidden = YES;
    self.summary.hidden = NO;
}

- (void)activateDisplayImageView
{
    self.background.frame = CGRectMake(padding, padding,
                                       320.0f - padding * 2,
                                       180.0f + 30.0f);
    
    float innerPadding = 10.0f;
    self.image.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.background.frame), 180.0f);
    self.title.frame = CGRectMake(innerPadding, CGRectGetHeight(self.image.frame), CGRectGetWidth(self.background.frame) - innerPadding * 2, 30.0f);
    self.summary.hidden = YES;
    self.image.hidden = NO;
}

- (float)height
{
    return CGRectGetHeight(self.background.frame) + padding * 2;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // recalculate heights
    CGSize summarySize = [self.summary.text sizeWithFont:self.summary.font
                                       constrainedToSize:CGSizeMake(self.background.frame.size.width, 9999.0f)
                                           lineBreakMode:NSLineBreakByWordWrapping];
    CGRect summaryFrame = self.summary.frame;
    summaryFrame.size.height = summarySize.height;
    self.summary.frame = summaryFrame;
    
    CGRect backgroundFrame = self.background.frame;
    backgroundFrame.size.height = padding * 2 + 30.0f + summarySize.height;
}

@end
