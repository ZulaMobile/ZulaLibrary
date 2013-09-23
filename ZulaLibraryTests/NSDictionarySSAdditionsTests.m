//
//  NSDictionarySSAdditionsTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSDictionary+SMAdditions.h"

@interface NSDictionarySSAdditionsTests : SenTestCase
@end

@implementation NSDictionarySSAdditionsTests

- (void)testShouldMergeSimpleDictionariesWithClassMethod
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

- (void)testShouldMergeAndOverrideDictionariesWithClassMethod
{
    NSDictionary *overridden = [NSDictionary dictionaryWithObjectsAndKeys:@"ali", @"name", @"engineer", @"title", nil];
    NSDictionary *overrides = [NSDictionary dictionaryWithObjectsAndKeys:@"ayse", @"name", @"doctor", @"title", @"sm123", @"id", @"active", @"status", nil];
    NSDictionary *result = [NSDictionary dictionaryByMerging:overridden with:overrides];
    
    STAssertTrue([result count] == 4, @"total count of items must be 4");
    STAssertTrue([[result objectForKey:@"name"] isEqualToString:@"ayse"], @"");
    STAssertTrue([[result objectForKey:@"title"] isEqualToString:@"doctor"], @"");
    STAssertTrue([[result objectForKey:@"id"] isEqualToString:@"sm123"], @"");
    STAssertTrue([[result objectForKey:@"status"] isEqualToString:@"active"], @"");
}

- (void)testShouldMergeSimpleDictionaries
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

- (void)testShouldMergeAndOverrideDictionaries
{
    NSDictionary *overridden = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"ali", @"name",
                                @"engineer", @"title", nil];
    NSDictionary *overrides = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"ayse", @"name",
                               @"doctor", @"title",
                               @"sm123", @"id",
                               @"active", @"status", nil];
    NSDictionary *result = [overridden dictionaryByMergingWith:overrides];
    
    STAssertTrue([result count] == 4, @"total count of items must be 4");
    STAssertTrue([[result objectForKey:@"name"] isEqualToString:@"ayse"], @"");
    STAssertTrue([[result objectForKey:@"title"] isEqualToString:@"doctor"], @"");
    STAssertTrue([[result objectForKey:@"id"] isEqualToString:@"sm123"], @"");
    STAssertTrue([[result objectForKey:@"status"] isEqualToString:@"active"], @"");
}

- (void)testShouldMergeMultiDimensionalDictionaries
{
    NSDictionary *mainAppearances = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"ff0000", @"bg_color",
                                     
                                     [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"aspect_fill", @"alignment",
                                      @"http://www.emobilez.com/wallpapers/data/media/298/nuclear_iphone_wallpapers.jpg", @"url",
                                      nil], @"bg_image",
                                     
                                     nil];
     
    NSDictionary *componentApperances =  [NSDictionary dictionaryWithObjectsAndKeys:
                                          
                                          [NSDictionary dictionaryWithObjectsAndKeys:@"aspect_fill", @"alignment", nil], @"image",
                                         
                                          [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"20", @"font_size",
                                          @"GillSans-Bold", @"font_family",
                                          @"F6FFA6", @"color",
                                          @"clean", @"bg_color",
                                          @"center", @"alignment", nil], @"title",
                                         //[NSDictionary dictionaryWithObjectsAndKeys:@"13", @"font_size", @"dddddd", @"color", nil], @"text",
     nil];
    
    NSDictionary *result = [NSDictionary dictionaryByMerging:componentApperances with:mainAppearances];
    
    STAssertTrue([result count] == 4, @"total count of items must be 4");
    STAssertTrue([[result objectForKey:@"bg_color"] isEqualToString:@"ff0000"], @"");
    
    NSDictionary *resultBgImage = [result objectForKey:@"bg_image"];
    STAssertTrue([[resultBgImage objectForKey:@"alignment"] isEqualToString:@"aspect_fill"], @"");
    STAssertTrue([[resultBgImage objectForKey:@"url"] isEqualToString:@"http://www.emobilez.com/wallpapers/data/media/298/nuclear_iphone_wallpapers.jpg"], @"");

    NSDictionary *image = [result objectForKey:@"image"];
    STAssertTrue([[image objectForKey:@"alignment"] isEqualToString:@"aspect_fill"], @"");
}

- (void)testShouldMergeAndOverrideMultiDimensionalDictionaries
{
    // main appearances needs to be overridden by component appearances
    NSDictionary *mainAppearances = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"ff0000", @"bg_color",
                                     
                                     [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"aspect_fill", @"alignment",
                                      @"http://www.emobilez.com/wallpapers/data/media/298/nuclear_iphone_wallpapers.jpg", @"url",
                                      nil], @"bg_image",
                                     
                                     nil];
    
    // component appearances overrides main appearances
    NSDictionary *componentApperances =  [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"444222", @"bg_color",
                                          
                                          [NSDictionary dictionaryWithObjectsAndKeys:
                                           @"center", @"alignment",
                                           @"http://overridden.png", @"url",
                                           nil], @"bg_image",
                                          
                                          [NSDictionary dictionaryWithObjectsAndKeys:@"aspect_fill", @"alignment", nil], @"image",
                                          
                                          [NSDictionary dictionaryWithObjectsAndKeys:
                                           @"20", @"font_size",
                                           @"GillSans-Bold", @"font_family",
                                           @"F6FFA6", @"color",
                                           @"clean", @"bg_color",
                                           @"center", @"alignment", nil], @"title",
                                          //[NSDictionary dictionaryWithObjectsAndKeys:@"13", @"font_size", @"dddddd", @"color", nil], @"text",
                                          nil];
    
    NSDictionary *result = [NSDictionary dictionaryByMerging:mainAppearances with:componentApperances];
    
    STAssertTrue([result count] == 4, @"total count of items must be 4");
    STAssertTrue([[result objectForKey:@"bg_color"] isEqualToString:@"444222"], @"");
    
    NSDictionary *resultBgImage = [result objectForKey:@"bg_image"];
    STAssertTrue([[resultBgImage objectForKey:@"alignment"] isEqualToString:@"center"], @"");
    STAssertTrue([[resultBgImage objectForKey:@"url"] isEqualToString:@"http://overridden.png"], @"");
    
    NSDictionary *image = [result objectForKey:@"image"];
    STAssertTrue([[image objectForKey:@"alignment"] isEqualToString:@"aspect_fill"], @"");
}

@end
