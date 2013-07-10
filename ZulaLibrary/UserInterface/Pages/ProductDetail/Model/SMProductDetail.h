//
//  ProductDetail.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/30/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMModel.h"
#import "SMServerError.h"

// data structure constants
#define kModelProductDetailTitle @"title"
#define kModelProductDetailText @"text"
#define kModelProductDetailImages @"images"
#define kModelProductDetailBackgroundImage @"bg_image"
#define kModelProductDetailNavbarIcon @"navbar_icon"

/**
 Product detail model. 
 
 See http://wiki.zulamobile.com/Product%20Component
 */
@interface SMProductDetail : SMModel

/**
 The title of the component
 */
@property (nonatomic, readonly) NSString *title;

/**
 The actual HTML content
 */
@property (nonatomic, readonly) NSString *text;

/**
 Multiple images to display on top of the page. Swipable.
 The array consists of NSURL objects that are image urls.
 */
@property (nonatomic, readonly) NSArray *images;

/**
 Optional background image
 */
@property (nonatomic) NSURL *backgroundUrl;

/**
 Optional navigation bar image that replaces the title
 */
@property (nonatomic) NSURL *navbarIcon;

/*
@property (nonatomic, readonly) NSString *imageGalleries;
@property (nonatomic, readonly) NSString *videoGalleries;
@property (nonatomic, readonly) NSString *form;
*/

/**
 Content data fetcher for this model
 */
+ (void)fetchWithURLString:(NSString *)urlString
                completion:(void(^)(SMProductDetail *productDetail, SMServerError *error))completion;

@end
