//
//  SMListPage.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 4/22/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMModel.h"

// data structure constants
#define kModelListPageTitle @"title"
#define kModelListPageBackgroundImageUrl @"bg_image"
#define kModelListPageItemBackgroundImageUrl @"item_bg_image"
#define kModelListPageListType @"listing_style"
#define kModelListPageItems @"items"
#define kModelListPageImages @"images"
#define kModelListNavbarIcon @"navbar_icon"

/**
 List Style Options that determines the display style
 */
typedef NS_ENUM(NSInteger, SMListingStyle) {
    SMListingStyleTable,                  // regular table view
    SMListingStyleBox,                    // preferences style table view
    SMListingStyleGroup                     
};

/**
 The model that provides data for `SMListComponent`
 
 @see [[List Component]] wiki page
 */
@interface SMListPage : SMModel

/**
 Page title, Header title
 */
@property (nonatomic, strong) NSString *title;

/**
 Multiple images to display on top of the page. Swipable.
 The array consists of NSURL objects that are image urls.
 */
@property (nonatomic, readonly) NSArray *images;

/**
 Optional background image
 */
@property (nonatomic, readonly) NSURL *backgroundUrl;

/**
 Optional navigation bar image that replaces the title
 */
@property (nonatomic) NSURL *navbarIcon;

/**
 Optional list item background image. Corresponds to table item background image.
 */
@property (nonatomic, readonly) NSURL *itemBackgroundUrl;

/**
 List Type, defaults to: `table`. Options are: `table`, `box`, `group`.
 */
@property (nonatomic, readonly) SMListingStyle listingStyle;

/**
 Listing Item collection. Stores `SMListItem` model objects.
 */
@property (nonatomic, readonly) NSArray *items;

/**
 Fetches and validates the downloaded list page
 For the format see [[GET List Page Service]]
 */
+ (void)fetchWithUrlString:(NSString *)urlString completion:(void(^)(SMListPage *listPage, NSError *error))completion;

@end
