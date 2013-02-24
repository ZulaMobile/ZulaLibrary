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
#import "SMTextView.h"

@interface SMContentPageViewController ()

/**
 scroll view as a wrapper for content view
 */
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SMContentPageViewController
@synthesize titleView = _titleView;
@synthesize imageView = _imageView;
@synthesize textView = _textView;
@synthesize scrollView = _scrollView;

- (void)loadView
{
    // screen size
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    NSLog(@"screen rect: %f, %f, %f, %f", screenRect.origin.x, screenRect.origin.y, screenRect.size.width, screenRect.size.height);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    [view setBackgroundColor:[UIColor yellowColor]];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    _imageView = [[SMImageView alloc] initWithFrame:CGRectMake(padding, padding, CGRectGetWidth(view.frame) - padding * 2, 150.0)];
    [_imageView setAutoresizesSubviews:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin];
    [_imageView applyAppearances:[self.componentDesciption.appearance objectForKey:@"image"]];
    
    _titleView = [[SMLabel alloc] initWithFrame:CGRectMake(padding, padding * 2 + CGRectGetHeight(_imageView.frame), CGRectGetWidth(view.frame) - padding * 2, 30)];
    [_titleView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_titleView applyAppearances:[self.componentDesciption.appearance objectForKey:@"title"]];
    [_titleView setText:@"sample text"];
    
    _textView = [[UIWebView alloc] initWithFrame:CGRectMake(padding, padding * 2 + CGRectGetHeight(_imageView.frame) + CGRectGetHeight(_titleView.frame), CGRectGetWidth(view.frame) - padding * 2, 600)];
    [_textView setAutoresizesSubviews:UIViewAutoresizingDefault];
    [_textView setDelegate:self];
    [_textView loadHTMLString:@"<html><body>Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.</body></html>" baseURL:[NSURL URLWithString:@"http://www.zulamobile.com/"]];
    
    [_scrollView addSubview:_imageView];
    [_scrollView addSubview:_titleView];
    [_scrollView addSubview:_textView];
    [view addSubview:_scrollView];
    
    [self setView:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // fetch the data and load the model
    
    // customize views
}

#pragma mark - web view delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    
    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
    [self.textView setFrame:CGRectMake(
                                       padding,
                                       padding + CGRectGetHeight(_titleView.frame) + _titleView.frame.origin.y,
                                       CGRectGetWidth(self.view.frame) - padding * 2,
                                       fittingSize.height)];
    [self.scrollView setContentSize:CGSizeMake(
                                               CGRectGetWidth(self.view.frame),
                                               padding * 2 + CGRectGetHeight(_titleView.frame) + _titleView.frame.origin.y +fittingSize.height)];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
