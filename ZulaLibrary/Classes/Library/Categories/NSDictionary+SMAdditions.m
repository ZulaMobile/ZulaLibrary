//
//  NSDictionary+SMAdditions.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/25/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "NSDictionary+SMAdditions.h"
#import <objc/runtime.h>

@implementation NSDictionary (SMAdditions)

- (NSDictionary*)dictionaryByMergingDictionary:(NSDictionary*)dictToOverride
{
    NSDictionary* theResult = [self mutableCopy];
    NSEnumerator* e = [dictToOverride keyEnumerator];
    id theKey = nil;
    while((theKey = [e nextObject]) != nil)
    {
        id theObject = [dictToOverride objectForKey:theKey];
        if ([theObject isKindOfClass:[NSDictionary class]] && [[self valueForKey:theKey] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *nval = [[self valueForKey:theKey] dictionaryByMergingDictionary:theObject];
            [theResult setValue:nval forKey:theKey];
        } else {
            [theResult setValue:theObject forKey:theKey];
        }
    }
    return theResult;
}


+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)overridden with:(NSDictionary *)overrides
{
    return [overridden dictionaryByMergingDictionary:overrides];
}

- (NSDictionary *)dictionaryByMergingWith:(NSDictionary *)dict {
    return [[self class] dictionaryByMerging:self with:dict];
}


@end
