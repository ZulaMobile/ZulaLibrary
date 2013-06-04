//
//  SMContactViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/3/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"
#import <MapKit/MapKit.h>

@class SMContact, SMWebView;

/**
 Contact controller to display maps, address info and a form
 */
@interface SMContactViewController : SMBaseComponentViewController <UIWebViewDelegate, MKMapViewDelegate>

@property (nonatomic, strong) SMContact *contact;

@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, strong) SMWebView *textView;

@end
