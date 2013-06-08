//
//  SMFormAction.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Executes and operation after the form is submitted
 */
@interface SMFormAction : NSObject

/**
 Sends the form data to the server
 */
- (void)executeWithCompletion:(void(^)(NSError *))completion;

@end
