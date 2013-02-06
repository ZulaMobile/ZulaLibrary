//
//  SMContentPage.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMModel.h"

// data structure constants
#define kModelContentPageTitle @"title"
#define kModelContentPageText @"text"
#define kModelContentPageImageUrl @"image_url"
#define kModelContentPageBackgroundImageUrl @"background_image_url"

/**
 Model class to provide the data for the `Content Page` object.
 
 The data structure in JSON notation is as follows:
 {'title':<string>, 'text':<string>, 'image_url':<string>}
 */
@interface SMContentPage : SMModel

/**
 The header title value of the content.
 */
@property (nonatomic, readonly) NSString *title;

/**
 The actual content to display in the page. HTML tags are allowed.
 */
@property (nonatomic, readonly) NSString *text;

/**
 Optional image to display on the page just above the title.
 */
@property (nonatomic, readonly) NSURL *imageUrl;

/**
 Optional background image
 */
@property (nonatomic, readonly) NSURL *backgroundUrl;

@end
