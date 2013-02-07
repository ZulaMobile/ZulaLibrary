//
//  SMAppLauncher.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMAppDescription;

/**
 Fetches the `app description` and loads components.
 */
@interface SMAppLauncher : NSObject

/**
 
 */
- (void)fetchAndSaveAppDescriptionWithBlock:(void(^)(SMAppDescription *description, NSError *error))block;



@end
