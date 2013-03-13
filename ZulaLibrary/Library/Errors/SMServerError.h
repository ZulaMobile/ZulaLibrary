//
//  SMServerError.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 3/13/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

@interface SMServerError : NSError

- (id)initWithOperation:(AFHTTPRequestOperation *)operation;

@end
