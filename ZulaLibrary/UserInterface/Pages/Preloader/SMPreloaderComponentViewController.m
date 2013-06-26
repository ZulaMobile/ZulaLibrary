//
//  SMPreloaderComponentViewController.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMPreloaderComponentViewController.h"
#import "SSLabel.h"

@interface SMPreloaderComponentViewController ()
- (void)onErrButton:(UIButton *)sender;
@end

@implementation SMPreloaderComponentViewController
{
    UIButton *errButton;
}
@synthesize delegate = _delegate;
@synthesize imageView = _imageView;
@synthesize activityIndicatorView = _activityIndicatorView;
@synthesize errorMessage = _errorMessage;

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.activityIndicatorView setFrame:CGRectMake(150, 420, 20, 20)];
    [self.activityIndicatorView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin];
    [self.activityIndicatorView startAnimating];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
    [self.imageView setImage:[UIImage imageNamed:@"zularesources.bundle/preload_splash"]];
    [self.imageView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    errButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [errButton setHidden:YES];
    
    [view addSubview:self.imageView];
    [view addSubview:errButton];
    [view addSubview:self.activityIndicatorView];
    
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

#pragma mark - methods

- (void)onAppFail
{
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView setHidden:YES];
    [errButton setHidden:NO];
    
    if (!self.errorMessage) {
        self.errorMessage = NSLocalizedString(@"A problem occurred and we couldn't launch the app. Tap anywhere to try again.", nil);
    }
    
    CGRect errFrame = CGRectMake(0,
                              0,
                              CGRectGetWidth(self.view.frame),
                              CGRectGetHeight(self.view.frame));
    
    [errButton setFrame:errFrame];
    [errButton setTitle:self.errorMessage forState:UIControlStateNormal];
    [errButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [errButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [errButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
    [errButton setBackgroundColor:[UIColor blackColor]];
    [errButton.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [errButton.titleLabel setNumberOfLines:0];
    [errButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [errButton addTarget:self action:@selector(onErrButton:) forControlEvents:UIControlEventTouchUpInside];
    [errButton setTag:666];
}

#pragma mark - private methods

- (void)onErrButton:(UIButton *)sender
{
    [self.activityIndicatorView startAnimating];
    [self.activityIndicatorView setHidden:NO];
    [errButton setHidden:YES];
    
    if ([self.delegate respondsToSelector:@selector(preloaderOnErrButton)]) {
        [self.delegate preloaderOnErrButton];
    }
}

@end
