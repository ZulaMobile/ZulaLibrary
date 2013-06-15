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
#import "SMMultipleImageView.h"
#import "SMPullToRefreshFactory.h"

@interface SMContentViewController ()

/**
 scroll view as a wrapper for content view
 */
@property (nonatomic, strong) SMScrollView *scrollView;

@end

@implementation SMContentViewController
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
    
    self.webView = [[SMWebView alloc] initWithFrame:
                    CGRectMake(padding,
                               padding,
                               CGRectGetWidth(self.view.frame) - padding * 2,
                               600)];
    [self.webView setAutoresizesSubviews:UIViewAutoresizingDefault];
    [self.webView applyAppearances:[self.componentDesciption.appearance objectForKey:@"text"]];
    [self.webView setDelegate:self];
    [self.webView disableScrollBounce];
    
    pullToRefresh = [SMPullToRefreshFactory pullToRefreshWithScrollView:self.scrollView delegate:self];
    
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
    if (![pullToRefresh isRefreshing])
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
    [_webView loadHTMLString:self.contentPage.text baseURL:[NSURL URLWithString:@"http://www.zulamobile.com/"]];
    
    // set images
    if ([self.contentPage.images count] > 0) {
        self.imageView = [[SMMultipleImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160.0)];
        [self.imageView setAutoresizesSubviews:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin];
        [self.imageView applyAppearances:[self.componentDesciption.appearance objectForKey:@"image"]];
        [self.imageView addImagesWithArray:self.contentPage.images];
        [self.scrollView addSubview:self.imageView];
    }
    
    if (self.contentPage.backgroundUrl)
        [self.backgroundImageView setImageWithURL:self.contentPage.backgroundUrl];
    
    // add navigation image if set
    if (self.contentPage.navbarIcon) {
        [self applyNavbarIconWithUrl:self.contentPage.navbarIcon];
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
    aWebView.frame = frame;
    
    // set web view size
    CGRect webViewFrame = self.webView.frame;
    webViewFrame.size.height = fittingSize.height;
    if (self.imageView) {
        webViewFrame.origin.y = CGRectGetHeight(self.imageView.frame);
        //webViewFrame.size.height += CGRectGetHeight(self.imageView.frame);
    }
    [self.webView setFrame:webViewFrame];
    
    // set scrollview content size
    CGSize contentSize = self.scrollView.contentSize;
    contentSize.height = CGRectGetHeight(self.imageView.frame) + CGRectGetHeight(self.webView.frame);
    [self.scrollView setContentSize:contentSize];
     
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
