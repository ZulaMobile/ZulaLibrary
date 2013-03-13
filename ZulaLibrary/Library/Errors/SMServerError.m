//
//  SMServerError.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 3/13/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMServerError.h"

@implementation SMServerError

- (id)initWithOperation:(AFHTTPRequestOperation *)operation
{
    self = [super initWithDomain:@"zulamobile" code:[operation.response statusCode] userInfo:nil];
    if (self) {
        
    }
    return self;
}

- (NSString *)localizedDescription
{
    NSString *localizedDesc;
    if (self.code == 403) {
        localizedDesc = NSLocalizedString(@"Authentication error.", nil);
    } else {
        localizedDesc = NSLocalizedString(@"Server error.", nil);
    }
    return localizedDesc;
}

@end
