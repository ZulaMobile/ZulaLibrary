//
//  SMServerError.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 3/13/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMServerError.h"
#import "AFHTTPRequestOperation.h"

@implementation SMServerError

- (id)initWithOperation:(AFHTTPRequestOperation *)operation
{
    self = [super initWithDomain:@"zulamobile" code:[operation.response statusCode] userInfo:nil];
    if (self) {
        // nothing to do
    }
    return self;
}

- (NSString *)localizedDescription
{
    NSString *localizedDesc;
    if (self.code == 403) {
        localizedDesc = NSLocalizedString(@"Authentication error.", nil);
    } else if (self.code == 502) {
        // malformed response, the response we receive is in incorrect format
        localizedDesc = NSLocalizedString(@"Malformed response.", nil);
    } else {
        localizedDesc = NSLocalizedString(@"Server error.", nil);
    }
    return localizedDesc;
}

@end
