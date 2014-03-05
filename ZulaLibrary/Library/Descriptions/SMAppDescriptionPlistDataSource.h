//
//  SMAppDescriptionPlistDataSource.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 06/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMAppDescriptionBaseDataSource.h"

/**
 *  Reads the app description from an arbitrary plist file
 */
@interface SMAppDescriptionPlistDataSource : SMAppDescriptionBaseDataSource

/**
 *  The path of the plist file
 */
@property (nonatomic, strong) NSString *path;

- (id)initWithPath:(NSString *)path;

@end
