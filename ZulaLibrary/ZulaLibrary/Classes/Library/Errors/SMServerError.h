//
//  SMServerError.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 3/13/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

/**
 Error class for server responses.
 Error code is set to the response status code and
 error description set to the server localized description.
 
 Use `localizedDescription` property to get the description variable.
 */
@interface SMServerError : NSError

- (id)initWithOperation:(AFHTTPRequestOperation *)operation;

@end
