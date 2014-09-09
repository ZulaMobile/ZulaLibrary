//
//  SMContactViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/3/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContactViewController.h"
#import <AddressBook/AddressBook.h>
#import <MapKit/MapKit.h>
#import "Macros.h"
#import "SMServerError.h"

#import "SMProgressHUD.h"
#import "UIWebView+SMAdditions.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+SMAdditions.h"
#import "UIColor+ZulaAdditions.h"

#import "SMAppDescription.h"
#import "SMComponentDescription.h"
#import "SMScrollView.h"
#import "SMContact.h"
#import "SMWebView.h"
#import "SMImageView.h"
#import "SMAnnotation.h"
#import "SMMapView.h"
#import "SMButton.h"

#import "SMFormDescription.h"
#import "SMFormTextField.h"
#import "SMFormSection.h"
#import "SMFormPasswordField.h"
#import "SMFormButtonField.h"
#import "SMFormEmailField.h"
#import "SMFormTextArea.h"

@interface SMContactViewController () <MKMapViewDelegate, SMMapViewDelegate>
@property (nonatomic, strong) SMScrollView *scrollView;
@property (nonatomic, strong) SMFormTableViewStrategy *formStrategy;
- (void)addRegionAndAnnotationLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude annotationName:(NSString *)name;
@end

@implementation SMContactViewController
@synthesize textView, mapView, scrollView, contactFormView, formStrategy, extraView;

- (void)loadView
{
    [super loadView];
    
    // screen size
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    self.padding = (CGPoint){0.0f, 20.0f};
    
    self.scrollView = [[SMScrollView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [self.scrollView applyAppearances:self.componentDesciption.appearance];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleAll];
    
    self.textView = [[SMWebView alloc] initWithFrame:
                    CGRectMake(self.padding.x,
                               self.padding.y,
                               CGRectGetWidth(self.view.frame) - self.padding.x * 2,
                               CGRectGetHeight(self.view.frame) - self.padding.y * 2)];
    [self.textView setAutoresizingMask:UIViewAutoresizingDefault];
    [self.textView applyAppearances:[self.componentDesciption.appearance objectForKey:@"text"]];
    [self.textView setDelegate:self];
    [self.textView disableScrollBounce];
    [self.textView setDataDetectorTypes:UIDataDetectorTypeAddress | UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber]; // detect phone numbers, addresses, etc.
    [self.textView setTag:401];
    
    self.extraView = [[SMWebView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  CGRectGetWidth(self.view.frame),
                                                                  CGRectGetHeight(self.view.frame))];
    [self.extraView setAutoresizingMask:UIViewAutoresizingDefault];
    [self.extraView applyAppearances:[self.componentDesciption.appearance objectForKey:@"extra"]];
    [self.extraView setDelegate:self];
    [self.extraView disableScrollBounce];
    [self.extraView setDataDetectorTypes:UIDataDetectorTypeAddress | UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber]; // detect phone numbers, addresses, etc.
    [self.extraView setTag:402];
    
    [self.scrollView addSubview:self.textView];
    [self.scrollView addSubview:self.extraView];
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame),
                                               CGRectGetWidth(self.textView.frame))];

    [self.view addSubview:self.scrollView];
}

#pragma mark - overridden methods

- (void)fetchContents
{
    [super fetchContents];
    
    NSString *url = [self.componentDesciption url];
    [SMContact fetchWithURLString:url Completion:^(SMContact *contactPage, SMServerError *error) {
        
        if (error) {
            NSLog(@"Contact page fetch contents error|%@", [error description]);
            
            // show error
            [self displayErrorString:error.localizedDescription];
            
            return;
        }
        
        self.model = contactPage;
        [self applyContents];
    }];
}

- (void)applyContents
{
    SMContact *contact = (SMContact *)self.model;
    
    [self setTitle:contact.title];
    
    [self.textView loadHTMLString:contact.text baseURL:[NSURL URLWithString:@"http://www.zulamobile.com/"]];
    [self.extraView loadHTMLString:contact.extra baseURL:[NSURL URLWithString:@"http://www.zulamobile.com/"]];
    
    if (contact.backgroundUrl)
        [self.backgroundImageView setImageWithURL:contact.backgroundUrl];
    
    // add navigation image if set
    [self applyNavbarIconWithUrl:contact.navbarIcon];
    
    // maps
    if ([contact hasCoordinates] && !self.mapView)
    {
        self.mapView = [[SMMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160.0)];
        [self.mapView setDelegate:self];
        [self.mapView setRouteButtonDelegate:self];
        [self.mapView setCenterCoordinate:contact.coordinates animated:NO];
        [self.mapView applyAppearances:[self.componentDesciption.appearance objectForKey:@"maps"]];
        
        [self.scrollView addSubview:mapView];
        
        CGRect textFrame = self.textView.frame;
        textFrame.origin.y += CGRectGetHeight(self.mapView.frame);
        [self.textView setFrame:textFrame];
        
        CGSize scrollSize = self.scrollView.contentSize;
        scrollSize.height += CGRectGetHeight(self.mapView.frame);
        [self.scrollView setContentSize:scrollSize];
     
        // fetch app title to display in annotation
        NSString *appTitle = [[SMAppDescription sharedInstance] appTitle];
        [self addRegionAndAnnotationLatitude:contact.coordinates.latitude longitude:contact.coordinates.longitude annotationName:appTitle];
    }
    
    // form
    if ([contact form] && !self.contactFormView) {
        [contact.form setExtraData:[NSDictionary dictionaryWithObjectsAndKeys:self.componentDesciption.type, @"type", self.componentDesciption.slug, @"slug", nil]];
        
        self.formStrategy = [[SMFormTableViewStrategy alloc] initWithDescription:contact.form scrollView:self.scrollView];
        [self.formStrategy setDelegate:self];
        self.contactFormView = [[UITableView alloc] initWithFrame:CGRectMake(0, 280, 320, 0) style:UITableViewStyleGrouped];
        [self.contactFormView setDelegate:self.formStrategy];
        [self.contactFormView setDataSource:self.formStrategy];
        [self.contactFormView setBackgroundView:nil];
        [self.contactFormView setBackgroundColor:[UIColor clearColor]];
        [self.scrollView addSubview:self.contactFormView];
    }
    
    [super applyContents];
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
    SMContact *contact = (SMContact *)self.model;
    
    CGRect frame = aWebView.frame;
    frame.size.height = 1;
    aWebView.frame = frame;
    CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    aWebView.frame = frame;
    
    if (aWebView.tag == 401) {
        CGRect textViewFrame = self.textView.frame;
        textViewFrame.size.height = fittingSize.height;
        
        CGSize scrollSize = self.scrollView.contentSize;
        scrollSize.height = CGRectGetHeight(self.textView.frame);
        
        // shift the text view if we have map view
        if ([contact hasCoordinates]) {
            //textViewFrame.origin.y += CGRectGetHeight(self.mapView.frame);
            scrollSize.height += CGRectGetHeight(self.mapView.frame);
        }
        
        // add the initial padding of the text view
        scrollSize.height += self.padding.y;
        
        self.textView.frame = textViewFrame;
        [self.scrollView setContentSize:scrollSize];
        
        if (self.contactFormView) {
            // get the height of the table
            [self.contactFormView layoutIfNeeded];
            float height = [self.contactFormView contentSize].height;
            
            // adjust table size
            [self.contactFormView setFrame:CGRectMake(0, self.textView.frame.origin.y + CGRectGetHeight(self.textView.frame), 320, height)];
            
            // adjust the scroll view after the form
            scrollSize = self.scrollView.contentSize;
            scrollSize.height += height;// 330;
            [self.scrollView setContentSize:scrollSize];
        }
    } else if (aWebView.tag == 402) {
        CGRect extraViewFrame = self.extraView.frame;
        extraViewFrame.size.height = fittingSize.height;
        if (self.contactFormView) {
            extraViewFrame.origin.y = self.contactFormView.frame.origin.y + CGRectGetHeight(self.contactFormView.frame);
        } else {
            extraViewFrame.origin.y = self.textView.frame.origin.y + CGRectGetHeight(self.textView.frame);
        }
        
        CGSize scrollSize = self.scrollView.contentSize;
        scrollSize.height += CGRectGetHeight(self.extraView.frame);
        
        self.extraView.frame = extraViewFrame;
        [self.scrollView setContentSize:scrollSize];
    }
    
    
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

#pragma mark - smwebview route button delegate

- (void)onRouteButton:(SMMapView *)mapView
{
    SMContact *contact = (SMContact *)self.model;
    
    NSString *os_version = [[UIDevice currentDevice] systemVersion];
    float os_v = [os_version floatValue];
    
    CLLocationDegrees latitude = contact.coordinates.latitude;
    CLLocationDegrees longitude = contact.coordinates.longitude;
    NSString* name = contact.title;
    
    if (os_v >= 6.0) {
        MKPlacemark* placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude)
                                                       addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:name,kABPersonAddressStreetKey, nil]];
        MKMapItem* mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        
        NSArray* mapItems = [NSArray arrayWithObjects:
                             mapItem,
                             nil];
        NSDictionary* launchOptions = [NSDictionary dictionaryWithObjectsAndKeys:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsDirectionsModeKey, nil];
        [MKMapItem openMapsWithItems:mapItems launchOptions:launchOptions];
    } else {
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.google.com/maps?saddr=Current+Location&daddr=%f,%f", latitude, longitude]]];
    }
}

#pragma mark - form delegate

- (void)form:(SMFormTableViewStrategy *)strategy didStartActionFromField:(SMFormField *)field
{
    [SMProgressHUD show];
}

- (void)form:(SMFormTableViewStrategy *)strategy didSuccesFromField:(SMFormField *)field
{
    [SMProgressHUD showSuccessWithStatus:NSLocalizedString(@"Submitted!", nil)];
}

- (void)form:(SMFormTableViewStrategy *)strategy didFailFromField:(SMFormField *)field
{
    [SMProgressHUD showSuccessWithStatus:NSLocalizedString(@"Submitted!", nil)];
    //[SMProgressHUD showErrorWithStatus:NSLocalizedString(@"Failed! Please try again", nil)];
}

@end
