//
//  SMComponentDescriptionTests.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMComponentDescriptionTests.h"
#import "SMComponentDescription.h"
#import "SMAppDescription.h"

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
    
    STAssertTrue([contentComponentDesc.appearance count] == 2, @"count of appearance options");
    STAssertTrue([contentComponentDesc.appearance isKindOfClass:[NSDictionary class]], @"appearance data type check");
    STAssertTrue([[contentComponentDesc.appearance objectForKey:@"test1"] isEqualToString:@"test1value"], @"");
    STAssertTrue([[contentComponentDesc.appearance objectForKey:@"test2"] isEqualToString:@"test2valueOverridden"], @"");
}

@end
