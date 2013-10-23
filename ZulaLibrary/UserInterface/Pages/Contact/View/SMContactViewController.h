//
//  SMContactViewController.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/3/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMPullToRefreshComponentViewController.h"
#import "SMFormTableViewStrategy.h"

@class SMContact, SMWebView, SMMapView;

/**
 Contact controller to display maps, address info and a form
 */
@interface SMContactViewController : SMPullToRefreshComponentViewController <UIWebViewDelegate, SMFormDelegate>

@property (nonatomic, strong) SMContact *contact;

@property (nonatomic, strong) SMMapView *mapView;

@property (nonatomic, strong) SMWebView *textView;

@property (nonatomic, strong) SMWebView *extraView;

@property (nonatomic, strong) UITableView *contactFormView;

@end
