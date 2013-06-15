//
//  SMProductDetailViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/30/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMProductDetailViewController.h"
#import <DDLog.h>

#import "SMProgressHUD.h"
#import "UIWebView+SMAdditions.h"
#import "UIViewController+SSToolkitAdditions.h"

#import "SMProductDetail.h"
#import "SMComponentDescription.h"
#import "SMMultipleImageView.h"
#import "SMLabel.h"
#import "SMTitleLabel.h"
#import "SMTextView.h"
#import "SMMainView.h"
#import "SMWebView.h"
#import "SMScrollView.h"
#import "SMPullToRefreshFactory.h"

@interface SMProductDetailViewController ()

/**
 scroll view as a wrapper for content view
 */
@property (nonatomic, strong) SMScrollView *scrollView;

@end

@implementation SMProductDetailViewController

- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    self.scrollView = [[SMScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [self.scrollView applyAppearances:self.componentDesciption.appearance];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    self.imageView = [[SMMultipleImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160.0)];
    [self.imageView setAutoresizesSubviews:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin];
    [self.imageView applyAppearances:[self.componentDesciption.appearance objectForKey:@"image"]];
    
    self.webView = [[SMWebView alloc] initWithFrame:
                    CGRectMake(padding,
                               CGRectGetHeight(self.imageView.frame),
                               CGRectGetWidth(self.view.frame) - padding * 2,
                               600)];
    [self.webView setAutoresizesSubviews:UIViewAutoresizingDefault];
    [self.webView applyAppearances:[self.componentDesciption.appearance objectForKey:@"text"]];
    [self.webView setDelegate:self];
    [self.webView disableScrollBounce];
    
    pullToRefresh = [SMPullToRefreshFactory pullToRefreshWithScrollView:self.scrollView delegate:self];
    
    [self.scrollView addSubview:self.imageView];
    [self.scrollView addSubview:self.webView];
    [self.view addSubview:self.scrollView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // fetch the data and load the model
    [self fetchContents];
}

#pragma mark - overridden methods

- (void)fetchContents
{
    // if data is already set, no need to fetch contents
    /*if (self.productDetail) {
        [self applyContents];
        return;
    }*/
    
    // start preloader
    if (![pullToRefresh isRefreshing])
        [SMProgressHUD show];
    
    NSString *url = [self.componentDesciption url];
    [SMProductDetail fetchWithURLString:url completion:^(SMProductDetail *productDetail, SMServerError *error) {
        // end preloader
        [SMProgressHUD dismiss];
        
        if (error) {
            DDLogError(@"Content page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        [self setProductDetail:productDetail];
        [self applyContents];
    }];
}

- (void)applyContents
{
    [self setTitle:self.productDetail.title];
    
    [self.webView loadHTMLString:self.productDetail.text baseURL:[NSURL URLWithString:@"http://www.zulamobile.com/"]];
    
    [self.imageView addImagesWithArray:self.productDetail.images];
    
    if (self.productDetail.backgroundUrl)
        [self.backgroundImageView setImageWithURL:self.productDetail.backgroundUrl];
    
    // add navigation image if set
    if (self.productDetail.navbarIcon) {
        [self applyNavbarIconWithUrl:self.productDetail.navbarIcon];
    }
    
    [pullToRefresh endRefresh];
}

#pragma mark - web view delegate

- (void)webViewDidStartLoad:(UIWebView *)aWebView
{
    
}

- (void)webView:(UIWebView *)aWebView didFailLoadWithError:(NSError *)error
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    CGRect frame = aWebView.frame;
    frame.size.height = 1;
    aWebView.frame = frame;
    CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    [aWebView setFrame:frame];
    
    // move views up if there is no image
    CGRect imageViewFrame = _imageView.frame;
    float imageHeight = (self.productDetail.images) ? CGRectGetHeight(imageViewFrame) : 0;
    [self.scrollView setContentSize:CGSizeMake(
                                               CGRectGetWidth(self.view.frame),
                                               padding * 2 + imageHeight + fittingSize.height)];
     
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
