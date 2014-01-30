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
        self.title.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.75];
        self.title.textColor = [UIColor whiteColor];
        self.title.font = [UIFont boldSystemFontOfSize:13.0f];
        
        self.image = [UIImageView new];
        self.image.backgroundColor = [UIColor yellowColor];
        self.image.contentMode = UIViewContentModeScaleAspectFill;
        self.image.clipsToBounds = YES;
        
        self.summary =  [UILabel new];
        self.summary.backgroundColor = [UIColor redColor];
        self.summary.numberOfLines = 4;
        self.summary.font = [UIFont systemFontOfSize:13.0f];
        
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
    self.background.frame = CGRectMake(padding, padding, 320.0f - padding * 2, 30.0 + 100.0f + padding * 2);
    
    float innerPadding = 10.0f;
    self.title.frame = CGRectMake(innerPadding, innerPadding, CGRectGetWidth(self.background.frame) - innerPadding * 2, 30.0f);
    self.summary.frame = CGRectMake(innerPadding, CGRectGetHeight(self.title.frame), CGRectGetWidth(self.background.frame)  - innerPadding * 2, 100.0f);
    self.image.hidden = YES;
    self.summary.hidden = NO;
}

- (void)activateDisplayImageView
{
    self.background.frame = CGRectMake(padding, padding, 320.0f - padding * 2, 180.0f + 30.0f + padding * 2);
    
    float innerPadding = 10.0f;
    self.image.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.background.frame), 180.0f);
    self.title.frame = CGRectMake(innerPadding, 180.0f, CGRectGetWidth(self.background.frame) - innerPadding * 2, 30.0f);
    self.summary.hidden = YES;
    self.image.hidden = NO;
}

- (float)height
{
    return CGRectGetHeight(self.background.frame) + padding * 2;
}

@end
