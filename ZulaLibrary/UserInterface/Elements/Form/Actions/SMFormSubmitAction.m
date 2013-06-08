//
//  SMFormSubmitAction.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormSubmitAction.h"

@implementation SMFormSubmitAction

- (void)executeActionWithDescription:(SMFormDescription *)description completion:(void (^)(NSError *))completion
{
    DDLogInfo(@"action happened");
    if (completion) {
        completion(nil);
    }
}

@end;
