//
//  AppCreatorLibrary.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/4/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

// application
#import "SMDefaultAppDelegate.h"
#import "SMPortfolioAppDelegate.h"
#import "SMNavigation.h"
#import "SMAppDescription.h"
#import "SMAppDescriptionRestApiDataSource.h"
#import "SMAppDescriptionDummyDataSource.h"
#import "SMAppDescriptionPlistDataSource.h"
#import "SMComponentDescription.h"

// view controllers
#import "SMBaseComponentViewController.h"
#import "SMPreloaderComponentViewController.h"
#import "SMHomePageViewController.h"
#import "SMSimpleTableViewController.h"

// views
#import "SMViewElement.h"
#import "SMImageView.h"

// forms
#import "SMFormField.h"
#import "SMFormDescription.h"
#import "SMFormTableViewStrategy.h"

// models
#import "SMModel.h"
#import "SMUser.h"

// library
#import "SMNotifications.h"
#import "SMServerError.h"
#import "SMApiClient.h"
#import "SMDownloadSession.h"
#import "SMProgressHUD.h"
#import "SMValidator.h"
#import "SMArrayDataSource.h"
#import "SMPullToRefreshFactory.h"

// categories
#import "UIViewController+SMAdditions.h"
#import "NSDictionary+SMAdditions.h"

// modules
#import "SMComponentModule.h"
#import "SMCustomAdvertisementModule.h"
#import "SMProgressHUDModule.h"
#import "SMSwipeBackModule.h"
#import "SMPullToRefreshModule.h"

// notifications
/*
kMalformedAppNotification @"kMalformedAppNotification"
kZulaNotificationPullToRefreshDidStartRefreshing @"kZulaNotificationPullToRefreshDidStartRefreshing"
kZulaNotificationPullToRefreshDidStopRefreshing @"kZulaNotificationPullToRefreshDidStopRefreshing"
*/

#define zulaLibraryVersion 0.3

#define UIViewAutoresizingFlexibleAll                       \
UIViewAutoresizingFlexibleBottomMargin    | \
UIViewAutoresizingFlexibleHeight          | \
UIViewAutoresizingFlexibleLeftMargin      | \
UIViewAutoresizingFlexibleRightMargin     | \
UIViewAutoresizingFlexibleTopMargin       | \
UIViewAutoresizingFlexibleWidth

#define UIViewAutoresizingFlexibleMargins                   \
UIViewAutoresizingFlexibleBottomMargin    | \
UIViewAutoresizingFlexibleLeftMargin      | \
UIViewAutoresizingFlexibleRightMargin     | \
UIViewAutoresizingFlexibleTopMargin

#define UIViewAutoresizingDefault UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin

// iphone 5 detector
#define IS_IPHONE_5 ([UIScreen mainScreen].bounds.size.height == 568.0)

// iOS version detector
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

// orientation detector
#define isLandscape() \
([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight)
#define isPortrait() \
([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)

// iPad/iPhone detector
#define isPad() \
([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && \
[[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad)

// retina screen detector
#define isRetina() \
([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
