//
//  NSDictionarySSAdditionsTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "NSDictionarySSAdditionsTests.h"

@implementation NSDictionarySSAdditionsTests

- (void)testMergeDictionarySimple
{
    NSDictionary *first = [NSDictionary dictionaryWithObjectsAndKeys:@"ali", @"name", @"engineer", @"title", nil];
    NSDictionary *second = [NSDictionary dictionaryWithObjectsAndKeys:@"sm123", @"id", @"active", @"status", nil];
    NSDictionary *result = [NSDictionary dictionaryByMerging:first with:second];
    
    STAssertTrue([result count] == 4, @"total count of items must be 4");
    STAssertTrue([[result objectForKey:@"name"] isEqualToString:@"ali"], @"");
    STAssertTrue([[result objectForKey:@"title"] isEqualToString:@"engineer"], @"");
    STAssertTrue([[result objectForKey:@"id"] isEqualToString:@"sm123"], @"");
    STAssertTrue([[result objectForKey:@"status"] isEqualToString:@"active"], @"");
}

- (void)testMergeDictionaryOverride
{
    NSDictionary *overridden = [NSDictionary dictionaryWithObjectsAndKeys:@"ali", @"name", @"engineer", @"title", nil];
    NSDictionary *overrides = [NSDictionary dictionaryWithObjectsAndKeys:@"ayse", @"name", @"doctor", @"title", @"sm123", @"id", @"active", @"status", nil];
    NSDictionary *result = [NSDictionary dictionaryByMerging:overrides with:overridden];
    
    STAssertTrue([result count] == 4, @"total count of items must be 4");
    STAssertTrue([[result objectForKey:@"name"] isEqualToString:@"ayse"], @"");
    STAssertTrue([[result objectForKey:@"title"] isEqualToString:@"doctor"], @"");
    STAssertTrue([[result objectForKey:@"id"] isEqualToString:@"sm123"], @"");
    STAssertTrue([[result objectForKey:@"status"] isEqualToString:@"active"], @"");
}

- (void)testMergeSelfDictionarySimple
{
    NSDictionary *first = [NSDictionary dictionaryWithObjectsAndKeys:@"ali", @"name", @"engineer", @"title", nil];
    NSDictionary *second = [NSDictionary dictionaryWithObjectsAndKeys:@"sm123", @"id", @"active", @"status", nil];
    NSDictionary *result = [second dictionaryByMergingWith:first];
    
    STAssertTrue([result count] == 4, @"total count of items must be 4");
    STAssertTrue([[result objectForKey:@"name"] isEqualToString:@"ali"], @"");
    STAssertTrue([[result objectForKey:@"title"] isEqualToString:@"engineer"], @"");
    STAssertTrue([[result objectForKey:@"id"] isEqualToString:@"sm123"], @"");
    STAssertTrue([[result objectForKey:@"status"] isEqualToString:@"active"], @"");
}

- (void)testMergeSelfDictionaryOverride
{
    NSDictionary *first = [NSDictionary dictionaryWithObjectsAndKeys:@"ali", @"name", @"engineer", @"title", nil];
    NSDictionary *second = [NSDictionary dictionaryWithObjectsAndKeys:@"ayse", @"name", @"doctor", @"title", @"sm123", @"id", @"active", @"status", nil];
    NSDictionary *result = [second dictionaryByMergingWith:first];
    
    STAssertTrue([result count] == 4, @"total count of items must be 4");
    STAssertTrue([[result objectForKey:@"name"] isEqualToString:@"ayse"], @"");
    STAssertTrue([[result objectForKey:@"title"] isEqualToString:@"doctor"], @"");
    STAssertTrue([[result objectForKey:@"id"] isEqualToString:@"sm123"], @"");
    STAssertTrue([[result objectForKey:@"status"] isEqualToString:@"active"], @"");
}

@end
