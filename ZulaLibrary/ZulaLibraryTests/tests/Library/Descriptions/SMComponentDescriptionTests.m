//
//  SMComponentDescriptionTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 06/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "GHUnit.h"
#import "SMComponentDescription.h"
#import "SMAppDescription.h"

@interface SMComponentDescriptionTests : GHTestCase

@end

@implementation SMComponentDescriptionTests

- (void)testComponentShouldOverrideApperances
{
    // set app description
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    NSDictionary *mainAppearances = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"test1value", @"test1",
                                     @"test2value", @"test2",
                                     nil];
    [appDescription setAppearance:mainAppearances];
    
    // set component description
    NSDictionary *componentAppearance = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @"test2valueOverridden", @"test2",
                                         nil];
    
    NSDictionary *componentAttributes = [NSDictionary dictionaryWithObjectsAndKeys:componentAppearance, @"appearance", nil];
    SMComponentDescription *contentComponentDesc = [[SMComponentDescription alloc] initWithAttributes:componentAttributes];
    [appDescription setComponentDescriptions:[NSArray arrayWithObject:contentComponentDesc]];
    
    GHAssertTrue([contentComponentDesc.appearance count] == 2, @"count of appearance options");
    GHAssertTrue([contentComponentDesc.appearance isKindOfClass:[NSDictionary class]], @"appearance data type check");
    GHAssertTrue([[contentComponentDesc.appearance objectForKey:@"test1"] isEqualToString:@"test1value"], @"");
    GHAssertTrue([[contentComponentDesc.appearance objectForKey:@"test2"] isEqualToString:@"test2valueOverridden"], @"");
}

- (void)testComponentShouldOverrideApperancesComplexJsonStrings
{
    // set app description
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    NSDictionary *mainAppearances = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @{@"font": @"helvetica", @"color": @"FF0000"}, @"label",
                                     @"test2value", @"test2",
                                     @{@"somekey": @"somevalue"}, @"test3",
                                     nil];
    [appDescription setAppearance:mainAppearances];
    
    // set component description
    NSDictionary *componentAppearance = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @"test2valueOverridden", @"test2",
                                         @{@"color": @"FFFFFF"}, @"label",
                                         @"only in second", @"test1",
                                         nil];
    
    NSLog(@"first: %@", mainAppearances);
    NSLog(@"-------");
    NSLog(@"second: %@", componentAppearance);
    NSLog(@"-------");
    
    NSDictionary *componentAttributes = [NSDictionary dictionaryWithObjectsAndKeys:componentAppearance, @"appearance", nil];
    SMComponentDescription *contentComponentDesc = [[SMComponentDescription alloc] initWithAttributes:componentAttributes];
    [appDescription setComponentDescriptions:[NSArray arrayWithObject:contentComponentDesc]];
    
    NSLog(@"result: %@", [contentComponentDesc appearance]);
    
    GHAssertTrue([contentComponentDesc.appearance count] == 4, @"count of appearance options");
    GHAssertTrue([contentComponentDesc.appearance isKindOfClass:[NSDictionary class]], @"appearance data type check");
    GHAssertTrue([[contentComponentDesc.appearance objectForKey:@"label"] isKindOfClass:[NSDictionary class]], @"label is a dict");
    
    NSDictionary *overriddenLabel = [contentComponentDesc.appearance objectForKey:@"label"];
    GHAssertTrue([[overriddenLabel objectForKey:@"font"] isEqualToString:@"helvetica"], @"");
    GHAssertTrue([[overriddenLabel objectForKey:@"color"] isEqualToString:@"FFFFFF"], @"");
    
    GHAssertTrue([[contentComponentDesc.appearance objectForKey:@"test2"] isEqualToString:@"test2valueOverridden"], @"");
    
    GHAssertTrue([[contentComponentDesc.appearance objectForKey:@"test3"] isKindOfClass:[NSDictionary class]], @"test3 is a dict");
    NSDictionary *test3Dict = [contentComponentDesc.appearance objectForKey:@"test3"];
    GHAssertTrue([[test3Dict objectForKey:@"somekey"] isEqualToString:@"somevalue"], @"");
    
    GHAssertTrue([[contentComponentDesc.appearance objectForKey:@"test1"] isEqualToString:@"only in second"], @"");
}

- (void)testComponentShouldOverrideApperancesComplexJsonStrings2
{
    // set app description
    SMAppDescription *appDescription = [SMAppDescription sharedInstance];
    NSDictionary *mainAppearances = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @{@"font": @"helvetica", @"color": @"FF0000"}, @"label",
                                     nil];
    [appDescription setAppearance:mainAppearances];
    
    // set component description
    NSDictionary *componentAppearance = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @{}, @"label",
                                         @{@"somekey": @"somevalue"}, @"test3",
                                         nil];
    
    NSDictionary *componentAttributes = [NSDictionary dictionaryWithObjectsAndKeys:componentAppearance, @"appearance", nil];
    SMComponentDescription *contentComponentDesc = [[SMComponentDescription alloc] initWithAttributes:componentAttributes];
    [appDescription setComponentDescriptions:[NSArray arrayWithObject:contentComponentDesc]];
    
    GHAssertTrue([contentComponentDesc.appearance count] == 2, @"count of appearance options");
    
    NSDictionary *overriddenLabel = [contentComponentDesc.appearance objectForKey:@"label"];
    GHAssertTrue([[overriddenLabel objectForKey:@"font"] isEqualToString:@"helvetica"], @"");
    GHAssertTrue([[overriddenLabel objectForKey:@"color"] isEqualToString:@"FF0000"], @"");
}

@end
