//
//  SMContentViewController.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContentViewController.h"
#import "SMComponentDescription.h"
#import "SMImageView.h"
#import "SMLabel.h"
#import "SMTitleLabel.h"
#import "SMTextView.h"
#import "SMMainView.h"
#import "SMWebView.h"
#import "SMScrollView.h"
#import "SMContentPage.h"
#import "SMProgressHUD.h"
#import "UIWebView+SMAdditions.h"
#import "UIViewController+SSToolkitAdditions.h"

@interface SMContentViewController ()

/**
 scroll view as a wrapper for content view
 */
@property (nonatomic, strong) SMScrollView *scrollView;

@end

@implementation SMContentViewController
@synthesize titleView = _titleView;
@synthesize imageView = _imageView;
@synthesize webView = _webView;
@synthesize scrollView = _scrollView;
@synthesize contentPage = _contentPage;

- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    self.scrollView = [[SMScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [self.scrollView applyAppearances:self.componentDesciption.appearance];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    self.imageView = [[SMImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100.0)];
    [self.imageView setAutoresizesSubviews:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin];
    [self.imageView applyAppearances:[self.componentDesciption.appearance objectForKey:@"image"]];
    
    self.titleView = [[SMTitleLabel alloc] initWithFrame:CGRectMake(padding, CGRectGetHeight(self.imageView.frame), CGRectGetWidth(self.view.frame) - padding * 2, 30)];
    [self.titleView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.titleView applyAppearances:[self.componentDesciption.appearance objectForKey:@"title"]];
    
    self.webView = [[SMWebView alloc] initWithFrame:
                    CGRectMake(padding,
                               CGRectGetHeight(self.imageView.frame),
                               CGRectGetWidth(self.view.frame) - padding * 2,
                               600)];
    [self.webView setAutoresizesSubviews:UIViewAutoresizingDefault];
    [self.webView applyAppearances:[self.componentDesciption.appearance objectForKey:@"text"]];
    [self.webView setDelegate:self];
    [self.webView disableScrollBounce];
    
    [self.scrollView addSubview:self.imageView];
    //[self.scrollView addSubview:self.titleView];
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
    if (self.contentPage) {
        [self applyContents];
        return;
    }
    
    // start preloader
    [SMProgressHUD show];
    
    NSString *url = [self.componentDesciption url];
    [SMContentPage fetchWithURLString:url Completion:^(SMContentPage *contentPage, SMServerError *error) {
        // end preloader
        [SMProgressHUD dismiss];
        
        if (error) {
            DDLogError(@"Content page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        [self setContentPage:contentPage];
        [self applyContents];
    }];
}

- (void)applyContents
{
    [_titleView setText:self.contentPage.title];
    [_webView loadHTMLString:self.contentPage.text baseURL:[NSURL URLWithString:@"http://www.zulamobile.com/"]];
    
    if (self.contentPage.imageUrl)
        [_imageView setImageWithURL:self.contentPage.imageUrl];
    
    if (self.contentPage.backgroundUrl)
        [self.backgroundImageView setImageWithURL:self.contentPage.backgroundUrl];
    
    // reposition elements
    if (!self.contentPage.imageUrl) {
        // move views up
        CGRect imageViewFrame = _imageView.frame;
        //CGRect titleViewFrame = _titleView.frame;
        CGRect webViewFrame = _webView.frame;
        //titleViewFrame.origin.y -= imageViewFrame.size.height;
        webViewFrame.origin.y -= imageViewFrame.size.height;
        //[_titleView setFrame:titleViewFrame];
        [_webView setFrame:webViewFrame];
    }
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
    aWebView.frame = frame;
    
    [self.webView setFrame:CGRectMake(padding,
                                      padding + CGRectGetHeight(self.imageView.frame),
                                      CGRectGetWidth(self.view.frame) - padding * 2,
                                      fittingSize.height)];
    [self.scrollView setContentSize:CGSizeMake(
                                               CGRectGetWidth(self.view.frame),
                                               padding * 2 + CGRectGetHeight(self.imageView.frame) + fittingSize.height)];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
