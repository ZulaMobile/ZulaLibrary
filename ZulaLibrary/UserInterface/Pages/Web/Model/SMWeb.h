//
//  SMWeb.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/12/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMModel.h"

@class SMServerError;

// data structure constants
#define kModelWebPageTitle @"title"
#define kModelWebPageUrl @"url"
#define kModelWebPageNavbarIcon @"navbar_icon"

/** 
 Data model for Web Component
 */
@interface SMWeb : SMModel

/**
 Page title
 */
@property (nonatomic, readonly) NSString *title;

/**
 The web page url
 */
@property (nonatomic, readonly) NSURL *url;

/**
 Optional navigation bar image that replaces the title
 */
@property (nonatomic, readonly) NSURL *navbarIcon;

+ (void)fetchWithURLString:(NSString *)urlString completion:(void (^)(SMWeb *, SMServerError *))completion;

@end
