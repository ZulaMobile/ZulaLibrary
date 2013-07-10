//
//  SMFormFieldTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormFieldTests.h"
#import "SMFormField.h"

@implementation SMFormFieldTests

- (void)testInitWithAttributes
{
    SMFormField *field = [[SMFormField alloc] initWithAttributes:
                          @{@"name": @"my-field", @"label": @"My Good Field"}];
    STAssertTrue([field.name isEqualToString:@"my-field"], @"label should have returned name instead");
    STAssertTrue([field.label isEqualToString:@"My Good Field"], @"label should have returned name instead");
}

- (void)testLabelShouldReturnNameIfEmptyPretty
{
    SMFormField *field = [[SMFormField alloc] initWithAttributes:
                          @{@"name": @"my-field"}];
    STAssertTrue([field.label isEqualToString:@"My Field"], @"label should have returned name instead");
    
    field = [[SMFormField alloc] initWithAttributes:
                          @{@"name": @"my_field"}];
    STAssertTrue([field.label isEqualToString:@"My Field"], @"label should have returned name instead");
    
    field = [[SMFormField alloc] initWithAttributes:
                          @{@"name": @"my field"}];
    STAssertTrue([field.label isEqualToString:@"My Field"], @"label should have returned name instead");
}

@end
