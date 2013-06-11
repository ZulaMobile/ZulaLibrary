//
//  SMContact.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/3/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMModel.h"
#import <MapKit/MapKit.h>

// data structure constants
#define kModelContactPageTitle @"title"
#define kModelContactPageText @"text"
#define kModelContactPageCoordinates @"maps"
#define kModelContactPageBackgroundImageUrl @"bg_image"
#define kModelContactPageNavbarIcon @"navbar_icon"
#define kModelContactFormDescription @"form"

@class SMFormDescription;

/**
 Contact component's data model
 Holds maps data, text data and form datas
 */
@interface SMContact : SMModel

/**
 Page title
 */
@property (nonatomic, readonly) NSString *title;

/**
 The http text area that should include address and phone information
 */
@property (nonatomic, readonly) NSString *text;

/**
 Latitude and Longitude of the map
 */
@property (nonatomic) CLLocationCoordinate2D coordinates;

/**
 The form description to create and display a form. 
 Form description stores all sections and fields in it.
 */
@property (nonatomic, readonly) SMFormDescription *form;

/**
 Optional background image
 */
@property (nonatomic, readonly) NSURL *backgroundUrl;

/**
 Optional navigation bar image that replaces the title
 */
@property (nonatomic, readonly) NSURL *navbarIcon;

/**
 Contact data getter
 See the data structure at [[GET Contact Page Service]] wiki entry
 */
+ (void)fetchWithURLString:(NSString *)urlString Completion:(void(^)(SMContact *contactPage, SMServerError *error))completion;

/**
 Returns YES if it has proper coordinates
 */
- (BOOL)hasCoordinates;

@end
