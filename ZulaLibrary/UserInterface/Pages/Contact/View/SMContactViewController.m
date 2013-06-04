//
//  SMContactViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/3/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContactViewController.h"
#import "SMProgressHUD.h"
#import "UIWebView+SMAdditions.h"
#import "UIViewController+SSToolkitAdditions.h"

#import "SMComponentDescription.h"
#import "SMScrollView.h"
#import "SMContact.h"
#import "SMWebView.h"
#import "SMImageView.h"
#import "SMAnnotation.h"

@interface SMContactViewController ()

@property (nonatomic, strong) SMScrollView *scrollView;
- (void)addRegionAndAnnotationLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude annotationName:(NSString *)name;
@end

@implementation SMContactViewController
@synthesize textView, mapView, scrollView;

- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    self.scrollView = [[SMScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [self.scrollView applyAppearances:self.componentDesciption.appearance];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    self.textView = [[SMWebView alloc] initWithFrame:
                    CGRectMake(padding,
                               padding,
                               CGRectGetWidth(self.view.frame) - padding * 2,
                               CGRectGetHeight(self.view.frame) - padding * 2)];
    [self.textView setAutoresizesSubviews:UIViewAutoresizingDefault];
    [self.textView applyAppearances:[self.componentDesciption.appearance objectForKey:@"text"]];
    [self.textView setDelegate:self];
    [self.textView disableScrollBounce];
    
    [self.scrollView addSubview:self.textView];
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame),
                                               CGRectGetWidth(self.textView.frame))];
    
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
    if (self.contact) {
        [self applyContents];
        return;
    }
    
    // start preloader
    [SMProgressHUD show];
    
    NSString *url = [self.componentDesciption url];
    [SMContact fetchWithURLString:url Completion:^(SMContact *contactPage, SMServerError *error) {
        // end preloader
        [SMProgressHUD dismiss];
        
        if (error) {
            DDLogError(@"Content page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        [self setContact:contactPage];
        [self applyContents];
    }];
}

- (void)applyContents
{
    [self setTitle:self.contact.title];
    
    [self.textView loadHTMLString:self.contact.text baseURL:[NSURL URLWithString:@"http://www.zulamobile.com/"]];
    
    if (self.contact.backgroundUrl)
        [self.backgroundImageView setImageWithURL:self.contact.backgroundUrl];
    
    // add navigation image if set
    if (self.contact.navbarIcon) {
        [self applyNavbarIconWithUrl:self.contact.navbarIcon];
    }
    
    // maps
    if ([self.contact hasCoordinates])
    {
        self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160.0)];
        [self.mapView setDelegate:self];
        [self.mapView setCenterCoordinate:self.contact.coordinates animated:NO];
        
        [self.scrollView addSubview:mapView];
        
        CGRect textFrame = self.textView.frame;
        textFrame.origin.y += CGRectGetHeight(self.mapView.frame);
        [self.textView setFrame:textFrame];
        
        CGSize scrollSize = self.scrollView.contentSize;
        scrollSize.height += CGRectGetHeight(self.mapView.frame);
        [self.scrollView setContentSize:scrollSize];
     
        [self addRegionAndAnnotationLatitude:self.contact.coordinates.latitude longitude:self.contact.coordinates.longitude annotationName:self.contact.title];
    }
    
    // rearrange contents if maps is set
}

#pragma mark - private methods

- (void)addRegionAndAnnotationLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude annotationName:(NSString *)name
{
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = latitude;
    newRegion.center.longitude = longitude;
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    
    SMAnnotation* annotation = [[SMAnnotation alloc] init];
    [annotation setName:name];
    [annotation setLatitude:latitude];
    [annotation setLongitude:longitude];
    
    [self.mapView addAnnotation:annotation];
    [self.mapView setRegion:newRegion animated:YES];
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
    
    CGRect textViewFrame = self.textView.frame;
    textViewFrame.size.height = fittingSize.height;
    
    CGSize scrollSize = self.scrollView.contentSize;
    scrollSize.height = CGRectGetHeight(self.textView.frame);
    
    // shift the text view if we have map view
    if ([self.contact hasCoordinates]) {
        //textViewFrame.origin.y += CGRectGetHeight(self.mapView.frame);
        scrollSize.height += CGRectGetHeight(self.mapView.frame) + padding * 2;
    }
    
    self.textView.frame = textViewFrame;
    [self.scrollView setContentSize:scrollSize];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
