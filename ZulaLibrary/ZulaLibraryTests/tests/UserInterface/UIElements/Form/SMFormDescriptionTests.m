//
//  SMFormDescriptionTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 06/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//
#import "GHUnit.h"
#import "SMFormDescription.h"
#import "SMFormSection.h"


@interface SMFormDescriptionTests : GHTestCase

@end

@implementation SMFormDescriptionTests
{
    NSDictionary *conf;
}

- (void)setUp
{
    NSArray *fieldsConf = @[@{@"type": @"text", @"name": @"name"},@{@"type": @"text", @"name": @"surname"}];
    NSArray *fieldsConf2 = @[@{@"type": @"text", @"name": @"message"}];
    NSArray *invalidFields = @[@{@"type": @"invalid_type", @"name": @"message"}];
    conf = @{@"sections":
                 @[
                     @{@"title": @"Section 1",
                       @"fields": fieldsConf},
                     @{@"title": @"Section 2",
                       @"fields": fieldsConf2},
                     @{@"title": @"Section 3",
                       @"fields": invalidFields}
                     ]
             };
}

- (void)testFormDescriptionInitWithDictionary
{
    SMFormDescription *desc = [[SMFormDescription alloc] initWithDictionary:conf];
    GHAssertTrue([desc.sections count] == 3, @"3 section should be");
    
    SMFormSection *section1 = [desc.sections objectAtIndex:0];
    GHAssertTrue([section1 isKindOfClass:[SMFormSection class]], @"type check");
    GHAssertTrue([[section1 title] isEqualToString:@"Section 1"], @"");
    GHAssertTrue([[section1 fields] count] == 2, @"");
    
    SMFormSection *section2 = [desc.sections objectAtIndex:1];
    GHAssertTrue([section2 isKindOfClass:[SMFormSection class]], @"type check");
    GHAssertTrue([[section2 title] isEqualToString:@"Section 2"], @"");
    GHAssertTrue([[section2 fields] count] == 1, @"");
}

- (void)testFormDescriptionInitWithDictionaryInvalidFields
{
    SMFormDescription *desc = [[SMFormDescription alloc] initWithDictionary:conf];
    GHAssertTrue([desc.sections count] == 3, @"3 section should be");
    
    SMFormSection *section = [desc.sections objectAtIndex:2];
    GHAssertTrue([section isKindOfClass:[SMFormSection class]], @"type check");
    GHAssertTrue([[section title] isEqualToString:@"Section 3"], @"");
    GHAssertTrue([[section fields] count] == 0, @"");
}

@end
