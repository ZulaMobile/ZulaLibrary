//
//  SMContactViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/3/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMBaseComponentViewController.h"
#import <MapKit/MapKit.h>
#import "SMMapView.h"
#import "SMFormTableViewStrategy.h"

@class SMContact, SMWebView;

/**
 Contact controller to display maps, address info and a form
 */
@interface SMContactViewController : SMBaseComponentViewController <UIWebViewDelegate, MKMapViewDelegate, SMMapViewDelegate, SMFormDelegate>

@property (nonatomic, strong) SMContact *contact;

@property (nonatomic, strong) SMMapView *mapView;

@property (nonatomic, strong) SMWebView *textView;

@property (nonatomic, strong) UITableView *contactFormView;

@end
