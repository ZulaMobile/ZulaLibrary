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
    UIView *view = [[UIView alloc] init];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_activityIndicatorView setFrame:CGRectMake(10, 10, 100, 100)];
    [_activityIndicatorView startAnimating];
    
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

@end
