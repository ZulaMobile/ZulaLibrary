//
//  SMFormFieldFactory.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMFormField;

/**
 Creates form fields using configuration
 */
@interface SMFormFieldFactory : NSObject

+ (SMFormField *)createFieldWithDictionary:(NSDictionary *)dictionary;

@end
