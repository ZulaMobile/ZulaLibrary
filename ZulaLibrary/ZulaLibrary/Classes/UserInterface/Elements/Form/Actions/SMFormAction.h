//
//  SMFormAction.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMFormDescription;

/**
 Executes and operation after the form is submitted
 */
@interface SMFormAction : NSObject

/**
 An action supposed to happen when tapping on a field, this can be submitting the form, or just some ui operation 
 */
- (void)executeActionWithDescription:(SMFormDescription *)description
                          completion:(void(^)(NSError *error))completion;

@end
