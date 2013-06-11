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
#import "SMFormTextArea.h"
#import "SMFormEmailField.h"

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
    } else if ([type isEqualToString:kFormPasswordFieldType]) {
        field = [[SMFormPasswordField alloc] initWithAttributes:dictionary];
    } else if ([type isEqualToString:kFormButtonFieldType]) {
        field = [[SMFormButtonField alloc] initWithAttributes:dictionary];
    } else if ([type isEqualToString:kFormEmailFieldType]) {
        field = [[SMFormEmailField alloc] initWithAttributes:dictionary];
    } else if ([type isEqualToString:kFormTextareaFieldType]) {
        field = [[SMFormTextArea alloc] initWithAttributes:dictionary];
    }

    return field;
}

@end
