//
//  SMFormDescription.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMFormField.h"

@class SMFormAction;
@protocol SMFormDescriptionDelegate;

/**
 The encapsulator around the configuration data.
 Takes the data and creates objects from it.
 Holds the data and acts like a data-source
 */
@interface SMFormDescription : NSObject <SMFormFieldDelegate>

/**
 Array of `SMFormSection` objects. Each section has its fields and an optional title.
 */
@property (nonatomic, strong) NSArray *sections;

/**
 Holds a pointer to the active field
 */
@property (nonatomic, weak) SMFormField *activeField;

/**
 Extra key-value pairs to add the form data.
 It is helpful to add some hidden data to the submitted form
 */
@property (nonatomic, strong) NSDictionary *extraData;

@property (nonatomic, weak) id<SMFormDescriptionDelegate> delegate;

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

/**
 Returns the field in a section
 */
- (SMFormField *)fieldWithIndexPath:(NSIndexPath *)indexPath;

/**
 Returns the data in dictionary, ready to post to server
 */
- (NSDictionary *)formData;

@end

@protocol SMFormDescriptionDelegate <NSObject>

@optional
- (void)fieldDidDemandAction:(SMFormField *)field;

@end
