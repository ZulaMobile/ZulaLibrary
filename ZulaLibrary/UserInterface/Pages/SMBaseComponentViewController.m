//
//  SMBaseComponentViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"
#import "SMComponentDescription.h"
#import "SMAppDescription.h"
#import "SMMainView.h"
#import "SMImageView.h"

@interface SMBaseComponentViewController ()

@end

@implementation SMBaseComponentViewController
@synthesize componentDesciption = _componentDesciption;
@synthesize backgroundImageView = _backgroundImageView;

- (id)initWithDescription:(SMComponentDescription *)description
{
    self = [super init];
    if (self) {
        [self setComponentDesciption:description];
        
        // configure component
        [self setTitle:self.componentDesciption.title];
        
        // padding default value
        padding = 10.0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // apply app wide appearaces
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    if ([self.view isKindOfClass:[SMMainView class]]) {
        [(SMMainView *)self.view applyAppearances:appDescription.appearance];
    }
    
    // set background image view if no subclass set it before
    if (!self.backgroundImageView) {
        NSDictionary *bgImageViewAppearance = [appDescription.appearance objectForKey:@"bg_image"];
        // if no app wide settings for bg image exists, dissmiss it
        if (bgImageViewAppearance) {
            NSURL *imageUrl = [NSURL URLWithString:[bgImageViewAppearance objectForKey:@"url"]];
            if (imageUrl) {
                _backgroundImageView = [[SMImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
                [_backgroundImageView applyAppearances:bgImageViewAppearance];
                [_backgroundImageView setAutoresizesSubviews:UIViewAutoresizingFlexibleAll];
                [_backgroundImageView setImageWithURL:imageUrl];
                [self.view addSubview:_backgroundImageView];
                [self.view sendSubviewToBack:_backgroundImageView];
            }
        }
    }
    
    
}

- (void)fetchContents
{
    // must be overridden
}

@end
