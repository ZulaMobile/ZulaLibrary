//
//  SMHomePage.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMModel.h"

// data structure constants
#define kModelHomePageImageLogo @"logo"
#define kModelHomePageBackgroundImageUrl @"bg_image"
#define kModelHomePageComponents @"components"

@interface SMHomePage : SMModel

/**
 Logo image url
 */
@property (nonatomic, readonly) NSURL *logoUrl;

/**
 Optional background image
 */
@property (nonatomic, readonly) NSURL *backgroundUrl;

/**
 *  Slugs of components. Only components that are listed here will be
 *  displayed by homepage component. If `components` are empty, then 
 *  all components will be displayed.
 */
@property (nonatomic, readonly) NSArray *components;

/**
 See the data structure at [[GET HomePage Service]] wiki entry
 */
+ (void)fetchWithURLString:(NSString *)urlString completion:(void(^)(SMHomePage *homePage, SMServerError *error))completion;

@end
