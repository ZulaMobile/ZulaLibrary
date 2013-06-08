//
//  SMFormDescription.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMFormAction, SMFormField;

/**
 The encapsulator around the configuration data.
 Takes the data and creates objects from it.
 Holds the data and acts like a data-source
 */
@interface SMFormDescription : NSObject

/**
 Array of `SMFormSection` objects. Each section has its fields and an optional title.
 */
@property (nonatomic, strong) NSArray *sections;

/**
 Loads data from the dictionary. The dictionary must 
 include at least `fields` set.
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

/**
 Initialize with already created `SMFormSection` subclasses.
 */
- (id)initWithSections:(NSArray *)formSections;

// Not Yet Implemented Methods
- (id)initWithJSONString:(NSString *)json;
- (id)initWithJSONFile:(NSString *)file;
- (id)initwithPlistFile:(NSString *)plistFile;

- (SMFormField *)fieldWithIndexPath:(NSIndexPath *)indexPath;

@end
