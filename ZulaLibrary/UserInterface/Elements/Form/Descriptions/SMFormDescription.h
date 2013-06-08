//
//  SMFormDescription.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMFormAction;

/**
 The encapsulator around the configuration data.
 Takes the data and creates objects from it.
 Holds the data and acts like a data-source
 */
@interface SMFormDescription : NSObject

/**
 Fields array stores the registered form fields that are subclasses of `SMFormField`
 A field renders the ui and stores the data in its ui object.
 */
@property (nonatomic, strong) NSArray *fields;

/**
 Loads data from the dictionary. The dictionary must 
 include at least `fields` set.
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

/**
 Initialize with already created `SMFormField` subclasses.
 */
- (id)initWithFields:(NSArray *)formFields;

// Not Yet Implemented Methods
- (id)initWithJSONString:(NSString *)json;
- (id)initWithJSONFile:(NSString *)file;
- (id)initwithPlistFile:(NSString *)plistFile;

@end
