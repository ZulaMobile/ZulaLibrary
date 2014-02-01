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
#import "UIViewController+SMAdditions.h"

#import "SMProductDetail.h"
#import "SMComponentDescription.h"
#import "SMMultipleImageView.h"
#import "SMLabel.h"
#import "SMTitleLabel.h"
#import "SMTextView.h"
#import "SMMainView.h"
#import "SMWebView.h"
#import "SMScrollView.h"

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
    [self.scrollView setAutoresizesSubviews:YES];
    
    self.imageView = [[SMMultipleImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160.0)];
    [self.imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin];
    [self.imageView applyAppearances:[self.componentDesciption.appearance objectForKey:@"image"]];
    
    self.webView = [[SMWebView alloc] initWithFrame:
                    CGRectMake(self.padding.x,
                               CGRectGetHeight(self.imageView.frame),
                               CGRectGetWidth(self.view.frame) - self.padding.x * 2,
                               600)];
    [self.webView setAutoresizingMask:UIViewAutoresizingDefault];
    [self.webView applyAppearances:[self.componentDesciption.appearance objectForKey:@"text"]];
    [self.webView setDelegate:self];
    [self.webView disableScrollBounce];
    
    [self.scrollView addSubview:self.imageView];
    [self.scrollView addSubview:self.webView];
    [self.view addSubview:self.scrollView];
}

#pragma mark - overridden methods

- (void)fetchContents
{
    [super fetchContents];
    
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
        
        self.model = productDetail;
        [self applyContents];
    }];
}

- (void)applyContents
{
    SMProductDetail *productDetail = (SMProductDetail *)self.model;
    
    [self setTitle:productDetail.title];
    
    [self.webView loadHTMLString:productDetail.text baseURL:[NSURL URLWithString:@"http://www.zulamobile.com/"]];
    
    [self.imageView addImagesWithArray:productDetail.images];
    
    if (productDetail.backgroundUrl)
        [self.backgroundImageView setImageWithURL:productDetail.backgroundUrl];
    
    // add navigation image if set
    [self applyNavbarIconWithUrl:productDetail.navbarIcon];
    
    [super applyContents];
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
    SMProductDetail *productDetail = (SMProductDetail *)self.model;
    
    CGRect frame = aWebView.frame;
    frame.size.height = 1;
    aWebView.frame = frame;
    CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    [aWebView setFrame:frame];
    
    // move views up if there is no image
    CGRect imageViewFrame = _imageView.frame;
    float imageHeight = (productDetail.images) ? CGRectGetHeight(imageViewFrame) : 0;
    [self.scrollView setContentSize:CGSizeMake(
                                               CGRectGetWidth(self.view.frame),
                                               self.padding.y * 2 + imageHeight + fittingSize.height)];
     
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
