//
//  SMFormSection.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A simple data holder that holds fields and section title
 */
@interface SMFormSection : NSObject

/**
 Fields array stores the registered form fields that are subclasses of `SMFormField`
 A field renders the ui and stores the data in its ui object.
 */
@property (nonatomic) NSArray *fields;

/**
 Optional section title
 */
@property (nonatomic, strong) NSString *title;

- (id)initWithTitle:(NSString *)theTitle fields:(NSArray *)theFields;

@end
