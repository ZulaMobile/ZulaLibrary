//
//  SMFormAction.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormAction.h"
#import "SMFormDescription.h"

/**
 Executes and operation after the form is submitted
 */
@implementation SMFormAction

- (void)executeActionWithDescription:(SMFormDescription *)description
                          completion:(void(^)(NSError *error))completion
{
    // must be overridden
}

@end
