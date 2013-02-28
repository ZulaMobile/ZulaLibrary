//
//  SMHomePage.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMModel.h"

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
 See the data structure at [[GET HomePage Service]] wiki entry
 */
+ (void)fetchWithCompletion:(void(^)(SMHomePage *homePage, NSError *error))completion;

@end
