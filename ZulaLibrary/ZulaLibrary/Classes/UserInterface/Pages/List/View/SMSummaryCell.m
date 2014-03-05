//
//  SMSummaryCell.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 27/01/14.
//  Copyright (c) 2014 laplacesdemon. All rights reserved.
//

#import "SMSummaryCell.h"


@implementation SMSummaryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.background = [UIView new];
        self.background.backgroundColor = [UIColor whiteColor];
        
        self.title = [UILabel new];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textColor = [UIColor darkTextColor];
        self.title.font = [UIFont boldSystemFontOfSize:13.0f];
        
        self.summary = [UILabel new];
        self.summary.backgroundColor = [UIColor clearColor];
        self.summary.textColor = [UIColor darkTextColor];
        self.summary.numberOfLines = 4;
        self.summary.font = [UIFont systemFontOfSize:13.0f];
        self.summary.lineBreakMode = NSLineBreakByWordWrapping;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self.background addSubview:self.title];
        [self.background addSubview:self.summary];
        
        [self addSubview:self.background];
        
        
    }
    return self;
}

- (void)applyAppearances:(NSDictionary *)appearances
{
    
}

- (void)adjustFrames
{
    float padding = PADDING;
    float titleHeight = 30.0f;
    float backgroundWidth = CGRectGetWidth(self.frame) - padding * 2.0f;
    CGSize summarySize = [self.summary.text sizeWithFont:self.summary.font
                                       constrainedToSize:CGSizeMake(backgroundWidth, 9999.0f)
                                           lineBreakMode:NSLineBreakByWordWrapping];
    float summaryHeight = summarySize.height;
    
    self.title.frame = CGRectMake(padding, padding, backgroundWidth - padding * 2, titleHeight);
    self.summary.frame = CGRectMake(padding, CGRectGetHeight(self.title.frame),
                                    backgroundWidth  - padding * 2, summaryHeight);
    self.summary.hidden = NO;
    
    self.background.frame = CGRectMake(padding, padding,
                                       backgroundWidth,
                                       titleHeight + summaryHeight + padding * 2.0f);
}

- (float)height
{
    return CGRectGetHeight(self.background.frame);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self adjustFrames];
}

@end


@implementation SMSummaryImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.image = [UIImageView new];
        self.image.backgroundColor = [UIColor colorWithHue:1 saturation:0.5 brightness:0.5 alpha:0.5];
        self.image.contentMode = UIViewContentModeScaleAspectFill;
        self.image.clipsToBounds = YES;
        
        [self.background addSubview:self.image];
        
    }
    return self;
}

- (void)adjustFrames
{
    float padding = PADDING;
    float titleHeight = 30.0f;
    float backgroundWidth = CGRectGetWidth(self.frame) - padding * 2.0f;
    float imageHeight = 180.0f;
    
    self.image.frame = CGRectMake(padding, padding, backgroundWidth, imageHeight);
    self.title.frame = CGRectMake(padding, CGRectGetHeight(self.image.frame) + self.image.frame.origin.y, backgroundWidth - padding * 2, titleHeight);
    self.summary.hidden = YES;
    
    self.background.frame = CGRectMake(padding, padding,
                                       backgroundWidth,
                                       titleHeight + imageHeight);
}

@end
