//
//  SMVideoGallery.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/29/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMModel.h"

// data structure constants
#define kModelVideoGalleryTitle @"title"
#define kModelVideoGalleryVideos @"videos"
#define kModelVideoGalleryBackgroundImage @"bg_image"
#define kModelVideoGalleryNavbarIcon @"navbar_icon"

#define kModelVideoTitle @"title"
#define kModelVideoUrl @"video_url"
#define kModelVideoDescription @"description"

@class SMVideo, SMServerError;

@interface SMVideoGallery : SMModel

/**
 The title of the component
 */
@property (nonatomic, readonly) NSString *title;

/**
 Collection of SMVideo objects.
 */
@property (nonatomic, readonly) NSArray *videos;

/**
 Optional background image
 */
@property (nonatomic) NSURL *backgroundUrl;

/**
 Optional navigation bar image that replaces the title
 */
@property (nonatomic) NSURL *navbarIcon;

+ (void)fetchWithURLString:(NSString *)urlString
                completion:(void (^)(SMVideoGallery *videoGallery, SMServerError *error))completion;

@end

/**
 Video class to be used in the video gallery
 */
@interface SMVideo : SMModel

/**
 the video url can be a youtube url or a direct video with
 an extension
 */
@property (nonatomic, readonly) NSURL *url;

/**
 Optional video title
 */
@property (nonatomic, readonly) NSString *title;

/**
 Optional short video description
 */
@property (nonatomic, readonly) NSString *description;

@end
