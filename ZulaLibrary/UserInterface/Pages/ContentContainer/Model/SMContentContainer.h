//
//  SMContentContainer.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMModel.h"
#import "SMServerError.h"

// data structure constants
#define kModelContentContainerTitle @"title"
#define kModelContentContainerComponents @"components"

/**
 This model is the collection of `SMContentPage` models.
 
 @see http://wiki.zulamobile.com/GET%20Content%20Container%20Page%20Service for details.
 */
@interface SMContentContainer : SMModel

/**
 Title of the component/page
 */
@property (nonatomic, readonly) NSString *title;

/**
 Collection of `SMContentPage` objects.
 */
@property (nonatomic, readonly) NSArray *components;

/**
 Content data fetcher for this model
 */
+ (void)fetchWithURLString:(NSString *)urlString
                completion:(void (^)(SMContentContainer *contentContainer, SMServerError *error))completion;

@end
