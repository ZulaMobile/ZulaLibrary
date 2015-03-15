//
//  SMFormFieldTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 06/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//
#import "GHUnit.h"
#import "SMFormField.h"


@interface SMFormFieldTests : GHTestCase

@end

@implementation SMFormFieldTests

- (void)testInitWithAttributes
{
    SMFormField *field = [[SMFormField alloc] initWithAttributes:
                          @{@"name": @"my-field", @"label": @"My Good Field"}];
    GHAssertTrue([field.name isEqualToString:@"my-field"], @"label should have returned name instead");
    GHAssertTrue([field.label isEqualToString:@"My Good Field"], @"label should have returned name instead");
}

- (void)testLabelShouldReturnNameIfEmptyPretty
{
    SMFormField *field = [[SMFormField alloc] initWithAttributes:
                          @{@"name": @"my-field"}];
    GHAssertTrue([field.label isEqualToString:@"My Field"], @"label should have returned name instead");
    
    field = [[SMFormField alloc] initWithAttributes:
             @{@"name": @"my_field"}];
    GHAssertTrue([field.label isEqualToString:@"My Field"], @"label should have returned name instead");
    
    field = [[SMFormField alloc] initWithAttributes:
             @{@"name": @"my field"}];
    GHAssertTrue([field.label isEqualToString:@"My Field"], @"label should have returned name instead");
}

@end
