//
//  SMContentPageViewController.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContentPageViewController.h"
#import "SMComponentDescription.h"
#import "SMImageView.h"
#import "SMLabel.h"

@interface SMContentPageViewController ()
@end

@implementation SMContentPageViewController

- (void)loadView
{
    // screen size
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    [view setBackgroundColor:[UIColor yellowColor]];
    
    _imageView = [[SMImageView alloc] initWithFrame:CGRectMake(padding, padding, CGRectGetWidth(view.frame) - padding * 2, 150.0)];
    [_imageView setAutoresizesSubviews:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin];
    [_imageView applyAppearances:[self.description.appearance objectForKey:@"image"]];
    
    _titleView = [[SMLabel alloc] initWithFrame:CGRectMake(padding, padding * 2 + CGRectGetHeight(_imageView.frame), CGRectGetWidth(view.frame) - padding * 2, 30)];
    [_titleView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_titleView applyAppearances:[self.description.appearance objectForKey:@"title"]];
    [_titleView setText:@"sample text"];
    
    [view addSubview:_titleView];
    [self setView:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // fetch the data and load the model
    
    // customize views
    
}

@end
