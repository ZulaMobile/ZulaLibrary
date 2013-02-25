//
//  SMPreloaderComponentViewController.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMPreloaderComponentViewController.h"

@interface SMPreloaderComponentViewController ()

@end

@implementation SMPreloaderComponentViewController
@synthesize imageView = _imageView;
@synthesize activityIndicatorView = _activityIndicatorView;

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_activityIndicatorView setFrame:CGRectMake(150, 420, 20, 20)];
    [_activityIndicatorView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin];
    [_activityIndicatorView startAnimating];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
    [_imageView setImage:[UIImage imageNamed:@"zularesources.bundle/preload_splash.png"]];
    [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    [view addSubview:_imageView];
    [view addSubview:_activityIndicatorView];
    
    [self setView:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

@end
