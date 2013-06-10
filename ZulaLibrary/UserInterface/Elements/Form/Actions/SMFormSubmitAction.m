//
//  SMFormSubmitAction.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFormSubmitAction.h"
#import "SMFormModel.h"

@implementation SMFormSubmitAction

- (void)executeActionWithDescription:(SMFormDescription *)description completion:(void (^)(NSError *))completion
{
    [SMFormModel submitFormDescription:description toUrlString:@"http://localhost:8000/api/v1/form/" completion:completion];
}

@end;
