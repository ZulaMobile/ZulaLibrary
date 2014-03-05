//
//  SMFormFieldFactoryTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 06/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "SMFormFieldFactory.h"
#import "SMFormField.h"
#import "SMFormTextField.h"


@interface SMFormFieldFactoryTests : GHTestCase

@end


@implementation SMFormFieldFactoryTests

- (void)testFactoryShouldFailIfFieldTypeNotSet
{
    id field = [SMFormFieldFactory createFieldWithDictionary:@{@"name": @"username"}];
    GHAssertNil(field, @"field must be nil");
}

- (void)testFactoryShouldFailIfFieldTypeIsUnknown
{
    id field = [SMFormFieldFactory createFieldWithDictionary:@{@"type": @"some_field", @"name": @"username"}];
    GHAssertNil(field, @"field must be nil");
}

- (void)testFactoryCreateTextFields
{
    id field = [SMFormFieldFactory createFieldWithDictionary:@{@"type": @"text", @"name": @"username"}];
    GHAssertTrue([field isKindOfClass:[SMFormField class]], @"form field should be a form field");
    GHAssertTrue([field isKindOfClass:[SMFormTextField class]], @"form field should be a text field");
    GHAssertTrue([[field name] isEqualToString:@"username"], @"field name must set");
}

@end
