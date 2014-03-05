//
//  SMVideoCell.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/29/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SMVideoCell.h"

@implementation SMVideoCell
{
    UIActivityIndicatorView *activityIndicator;
}
@synthesize videoLabel, videoView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect bounds = [[UIScreen mainScreen] bounds];
        float height = 160.0f;
        float padding = 5.0f;
        
        UIView *wrapper = [[UIView alloc] initWithFrame:CGRectMake(padding, padding, CGRectGetWidth(bounds) - padding * 2, height - padding)];
        //[wrapper setUserInteractionEnabled:NO];
        [wrapper setBackgroundColor:[UIColor whiteColor]];
        [wrapper.layer setShadowColor:[UIColor grayColor].CGColor];
        [wrapper.layer setShadowOffset:CGSizeMake(1, 1)];
        [wrapper.layer setShadowOpacity:1.0];
        [wrapper.layer setShadowRadius:1.0];
        
        UIView *labelWrapper = [[UIView alloc] initWithFrame:CGRectMake(padding, CGRectGetHeight(wrapper.frame) - padding - 30, CGRectGetWidth(wrapper.frame) - padding * 2, 30)];
        [labelWrapper setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.75f]];
        [labelWrapper setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth];
        
        videoLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, CGRectGetWidth(labelWrapper.frame) - padding * 2, CGRectGetHeight(labelWrapper.frame))];
        [videoLabel setTextColor:[UIColor whiteColor]];
        [videoLabel setBackgroundColor:[UIColor clearColor]];
        [videoLabel setShadowColor:[UIColor blackColor]];
        [videoLabel setShadowOffset:CGSizeMake(0, 1)];
        [videoLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
        [videoLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [labelWrapper addSubview:videoLabel];

        videoView = [[UIWebView alloc] initWithFrame:CGRectMake(padding, padding, CGRectGetWidth(wrapper.frame) - padding * 2, CGRectGetHeight(wrapper.frame) - padding * 2)];
        [videoView setHidden:YES];
        //[storyVideo loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.youtube.com/embed/%@?rel=0", [story.video youtubeId]]]]];

        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicator hidesWhenStopped];
        float activityWidth = 20.0; float activityHeight = 20.0;
        [activityIndicator setFrame:CGRectMake(CGRectGetWidth(wrapper.frame) / 2 - activityWidth / 2, CGRectGetHeight(wrapper.frame) / 2 - activityHeight / 2 - 30.0f / 2, activityWidth, activityHeight)];
        [activityIndicator startAnimating];
        
        [wrapper addSubview:videoView];
        [wrapper addSubview:labelWrapper];
        [wrapper addSubview:activityIndicator];
        
        [self.contentView addSubview:wrapper];
    }
    return self;
}

- (void)showVideoWithUrl:(NSURL *)url
{
    if (url) {
        //[videoView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.youtube.com/embed/%@?rel=0&showinfo=0", @"N1LzUVasdtU"]]]];
        [videoView loadRequest:[NSURLRequest requestWithURL:url]];
        [videoView setBackgroundColor:[UIColor orangeColor]];
        [videoView setHidden:NO];
        [activityIndicator stopAnimating];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
