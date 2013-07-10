//
//  SMImageGallery.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMModel.h"

// data structure constants
#define kModelImageGalleryTitle @"title"
#define kModelImageGalleryImages @"images"
#define kModelImageGalleryBackgroundImage @"bg_image"
#define kModelImageGalleryNavbarIcon @"navbar_icon"

@class SMServerError;

@interface SMImageGallery : SMModel

/**
 The title of the component
 */
@property (nonatomic, readonly) NSString *title;

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

+ (void)fetchWithURLString:(NSString *)urlString
                completion:(void (^)(SMImageGallery *imageGallery, SMServerError *error))completion;

@end
