//
//  NSDictionary+SMAdditions.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SMAdditions)

/**
 Merges 2 dictionaries
 dict2 will overridden by the values of dict1
 */
+ (NSDictionary *) dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;

/**
 Merges the dictionary with given dictionary
 Given dictionary values will be overridden by the original dictionary
 */
- (NSDictionary *)dictionaryByMergingWith:(NSDictionary *)dict;

@end
