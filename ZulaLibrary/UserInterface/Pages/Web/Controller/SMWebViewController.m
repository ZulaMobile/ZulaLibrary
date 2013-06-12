//
//  SMWebViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/12/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMWebViewController.h"

#import "SMProgressHUD.h"
#import "SMComponentDescription.h"
#import "SMAppDescription.h"
#import "UIWebView+SMAdditions.h"
#import "UIViewController+SSToolkitAdditions.h"

#import "SMWeb.h"
#import "SMWebView.h"

@interface SMWebViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation SMWebViewController
@synthesize web=_web, webView=_webView, indicatorView=_indicatorView;

- (void)loadView
{
    [super loadView];
    
    self.webView = [[SMWebView alloc] initWithFrame:
                     CGRectMake(0,
                                0,
                                CGRectGetWidth(self.view.frame),
                                CGRectGetHeight(self.view.frame))];
    [self.webView setAutoresizesSubviews:UIViewAutoresizingDefault];
    [self.webView setDelegate:self];
    [self.webView setBackgroundColor:[UIColor whiteColor]];
    [self.webView setDataDetectorTypes:UIDataDetectorTypeAddress | UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber]; // detect phone numbers, addresses, etc.
    
    // set background color to app's backgorund
    SMAppDescription *appDesc = [SMAppDescription sharedInstance];
    NSDictionary *appearance = [appDesc.appearance objectForKey:@"bg_image"];
    if ([appearance isKindOfClass:[NSDictionary class]]) {
        [self.webView applyAppearances:appearance];
    }
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.indicatorView setFrame:CGRectMake(CGRectGetWidth(self.view.frame) / 2 - 20, CGRectGetHeight(self.view.frame) / 2 - 20, 20, 20)];
    [self.indicatorView setHidesWhenStopped:YES];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.indicatorView];
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
    if (self.web) {
        [self applyContents];
        return;
    }
    
    // start preloader
    [SMProgressHUD show];
    
    NSString *url = [self.componentDesciption url];
    [SMWeb fetchWithURLString:url completion:^(SMWeb *theWeb, SMServerError *error) {
        // end preloader
        [SMProgressHUD dismiss];
        
        if (error) {
            DDLogError(@"Web page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        [self setWeb:theWeb];
        [self applyContents];
    }];
}

- (void)applyContents
{
    [self setTitle:self.web.title];
    
    if (self.web.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.web.url]];
    }
    
    // add navigation image if set
    if (self.web.navbarIcon) {
        [self applyNavbarIconWithUrl:self.web.navbarIcon];
    }
    
}

#pragma mark - web view delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.indicatorView stopAnimating];
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                message:NSLocalizedString(@"The web page could not be loaded!", nil)
                               delegate:self
                      cancelButtonTitle:NSLocalizedString(@"Close", nil)
                      otherButtonTitles:nil, nil] show];
}

#pragma mark - alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
