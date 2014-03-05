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
#import "UIWebView+SMAdditions.h"
#import "UIViewController+SMAdditions.h"
#import "SMMultipleImageView.h"

@interface SMContentViewController ()

/**
 scroll view as a wrapper for content view
 */
@property (nonatomic, strong) SMScrollView *scrollView;

- (void)deviceOrientationDidChange:(NSNotification *)notification;

@end

@implementation SMContentViewController
@synthesize imageView = _imageView;
@synthesize webView = _webView;
@synthesize scrollView = _scrollView;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    self.scrollView = [[SMScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [self.scrollView applyAppearances:self.componentDesciption.appearance];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    self.scrollView.autoresizesSubviews = YES;
    
    /*
    self.webView = [[SMWebView alloc] initWithFrame:
                    CGRectMake(padding,
                               padding,
                               CGRectGetWidth(self.view.frame) - padding * 2,
                               0)];*/
    self.webView = [[SMWebView alloc] initWithFrame:self.scrollView.frame];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleAll;
    [self.webView applyAppearances:[self.componentDesciption.appearance objectForKey:@"text"]];
    [self.webView setDelegate:self];
    [self.webView disableScrollBounce];
    
    [self.scrollView addSubview:self.webView];
    [self.view addSubview:self.scrollView];
    
    // orientation notifiers
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
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
    [super fetchContents];
    
    // check if there are offline content instead of server one
    if (![self.componentDesciption hasDownloadableContents]) {
        
        // the contents are ready
        SMContentPage *contentPage = [[SMContentPage alloc] initWithAttributes:self.componentDesciption.contents];
        self.model = contentPage;
        [self applyContents];
        return;
    }
    
    // there are downloadable content. fetch it from the webservice.
    NSString *url = [self.componentDesciption contents];
    
    [SMContentPage fetchWithURLString:url Completion:^(SMContentPage *aContentPage, SMServerError *error) {
        
        if (error) {
            DDLogError(@"Content page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            [self applyContents];
            return;
        }
        
        self.model = aContentPage;
        [self applyContents];
    }];
}

- (void)applyContents
{
    SMContentPage *contentPage = (SMContentPage *)self.model;
    
    [_webView loadHTMLString:contentPage.text baseURL:[NSURL URLWithString:@"http://www.zulamobile.com/"]];
    
    // set images
    if ([contentPage.images count] > 0) {
        self.imageView = [[SMMultipleImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160.0)];
        [self.imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin];
        [self.imageView applyAppearances:[self.componentDesciption.appearance objectForKey:@"image"]];
        [self.imageView addImagesWithArray:contentPage.images];
        [self.scrollView addSubview:self.imageView];
    } else {
        // unset images if set before
        if (self.imageView) {
            [self.imageView removeFromSuperview];
            self.imageView = nil;
        }
    }
    
    if (contentPage.backgroundUrl) {
        // set background
        [self.backgroundImageView setImageWithURL:contentPage.backgroundUrl];
    } else if (self.backgroundImageView) {
        // unset background
        [self.backgroundImageView setImage:nil];
    }
    
    // add navigation image if set
    [self applyNavbarIconWithUrl:contentPage.navbarIcon];
    
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

#pragma mark - private methods

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    [self webViewDidFinishLoad:self.webView];
}

@end
