//
//  SMContactViewController.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/3/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContactViewController.h"
#import <AddressBook/AddressBook.h>
#import "SMProgressHUD.h"
#import "UIWebView+SMAdditions.h"
#import "UIViewController+SSToolkitAdditions.h"
#import "UIColor+SSToolkitAdditions.h"

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

@interface SMContactViewController ()
@property (nonatomic, strong) SMScrollView *scrollView;
@property (nonatomic, strong) SMFormTableViewStrategy *formStrategy;
- (void)addRegionAndAnnotationLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude annotationName:(NSString *)name;
@end

@implementation SMContactViewController
@synthesize textView, mapView, scrollView, contactFormView, formStrategy;

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
    [self.textView setDataDetectorTypes:UIDataDetectorTypeAddress | UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber]; // detect phone numbers, addresses, etc.
    
    [self.scrollView addSubview:self.textView];
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame),
                                               CGRectGetWidth(self.textView.frame))];

    
    // form
    NSArray *fields = [NSArray arrayWithObjects:
                       [[SMFormTextField alloc] initWithAttributes:@{@"name": @"username"}],
                       [[SMFormEmailField alloc] initWithAttributes:@{@"name": @"email"}],
                       [[SMFormTextArea alloc] initWithAttributes:@{@"name": @"Message"}],
                       nil];
    NSArray *buttons = [NSArray arrayWithObjects:
                       [[SMFormButtonField alloc] initWithAttributes:@{@"name": @"submit"}],
                       nil];
    SMFormSection *section = [[SMFormSection alloc] initWithTitle:@"Login Form" fields:fields];
    SMFormSection *buttonSection = [[SMFormSection alloc] initWithTitle:@"" fields:buttons];
    NSArray *sections = [NSArray arrayWithObjects:section, buttonSection, nil];
    
    SMFormDescription *formDescription = [[SMFormDescription alloc] initWithSections:sections];
    self.formStrategy = [[SMFormTableViewStrategy alloc] initWithDescription:formDescription scrollView:self.scrollView];
    [self.formStrategy setDelegate:self];
    self.contactFormView = [[UITableView alloc] initWithFrame:CGRectMake(0, 280, 320, 400) style:UITableViewStyleGrouped];
    [self.contactFormView setDelegate:self.formStrategy];
    [self.contactFormView setDataSource:self.formStrategy];
    [self.contactFormView setBackgroundView:nil];
    [self.contactFormView setBackgroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:self.contactFormView];
    
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
        self.mapView = [[SMMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160.0)];
        [self.mapView setDelegate:self];
        [self.mapView setRouteButtonDelegate:self];
        [self.mapView setCenterCoordinate:self.contact.coordinates animated:NO];
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
        [self addRegionAndAnnotationLatitude:self.contact.coordinates.latitude longitude:self.contact.coordinates.longitude annotationName:appTitle];
        
        
        
        
        
        
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
    
    
    // TEMP FORM
    /*
    UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake(10, scrollSize.height, 300, 31)];
    UITextField *email = [[UITextField alloc] initWithFrame:CGRectMake(10, name.frame.origin.y + CGRectGetHeight(name.frame) + 10, 300, 31)];
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(10, email.frame.origin.y + CGRectGetHeight(email.frame) + 10, 300, 120)];
    SMButton *submit = [[SMButton alloc] initWithFrame:CGRectMake(10, text.frame.origin.y + CGRectGetHeight(text.frame) + 10, 300, 31)];
    
    [name setPlaceholder:@"İsim Soyisim"];
    [email setPlaceholder:@"Eposta"];
    [text setPlaceholder:@"Mesajiniz"];
    [name setBorderStyle:UITextBorderStyleRoundedRect];
    [email setBorderStyle:UITextBorderStyleRoundedRect];
    [text setBorderStyle:UITextBorderStyleRoundedRect];
    [submit setTitle:@"Gönder" forState:UIControlStateNormal];
    [submit setBackgroundColor:[UIColor colorWithHex:@"27B3E6"]];
    
    [self.scrollView addSubview:name];
    [self.scrollView addSubview:email];
    [self.scrollView addSubview:text];
    [self.scrollView addSubview:submit];
    scrollSize = self.scrollView.contentSize;
    scrollSize.height = submit.frame.origin.y + CGRectGetHeight(submit.frame) + 10;
    [self.scrollView setContentSize:scrollSize];
    // ENDTEMP FORM
    */
    scrollSize = self.scrollView.contentSize;
    scrollSize.height += 330;
    [self.scrollView setContentSize:scrollSize];
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
    NSString *os_version = [[UIDevice currentDevice] systemVersion];
    float os_v = [os_version floatValue];
    
    CLLocationDegrees latitude = self.contact.coordinates.latitude;
    CLLocationDegrees longitude = self.contact.coordinates.longitude;
    NSString* name = self.contact.title;
    
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
    DDLogInfo(@"push to the server");
    [SMProgressHUD show];
    
    
}

@end
