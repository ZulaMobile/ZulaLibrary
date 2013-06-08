//
//  SMFormFieldFactory.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormFieldFactory.h"
#import "SMFormField.h"
#import "SMFormTextField.h"
#import "SMFormPasswordField.h"
#import "SMFormButtonField.h"

@implementation SMFormFieldFactory

+ (SMFormField *)createFieldWithDictionary:(NSDictionary *)dictionary
{
    NSString *type = [dictionary objectForKey:@"type"];
    if (!type || [type isEqualToString:@""]) {
        return nil;
    }

    SMFormField *field = nil;
    if ([type isEqualToString:kFormTextFieldType]) {
        field = [[SMFormTextField alloc] initWithAttributes:dictionary];
    } else if ([type isEqualToString:@"password"]) {
        field = [[SMFormPasswordField alloc] initWithAttributes:dictionary];
    } else if ([type isEqualToString:@"button"]) {
        field = [[SMFormButtonField alloc] initWithAttributes:dictionary];
    }

    return field;
}

@end
