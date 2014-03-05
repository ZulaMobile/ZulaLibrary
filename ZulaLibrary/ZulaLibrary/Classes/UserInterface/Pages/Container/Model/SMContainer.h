//
//  SMContainer.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMModel.h"

// data structure constants
#define kModelContainerPageTitle @"title"
#define kModelPageComponents @"components"
#define kModelPageNavigationBarIcon @"navbar_icon"

@class SMServerError;

/**
 Container Page holds multiple components in its `components` attribute
 */
@interface SMContainer : SMModel

/**
 Page title
 */
@property (nonatomic, strong) NSString *title;

/**
 List of `SMComponentDescription` objects
 */
@property (nonatomic, strong) NSArray *components;

/**
 Optional navigation bar image that replaces the title
 */
@property (nonatomic, readonly) NSURL *navbarIcon;

+ (void)fetchWithURLString:(NSString *)urlString completion:(void (^)(SMContainer *, SMServerError *))completion;

@end
