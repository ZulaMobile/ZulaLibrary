//
//  SMDownloadSession.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 23/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMDownloadSession.h"
#import "AFHTTPRequestOperation.h"

@interface SMDownloadSession ()
@property (nonatomic, strong) AFHTTPRequestOperation *operation;
@end

@implementation SMDownloadSession
@synthesize operation;

- (id)initWithRequestOperation:(AFHTTPRequestOperation *)anOperation
{
    self = [super init];
    if (self) {
        self.operation = anOperation;
    }
    return self;
}

- (void)pause
{
    [self.operation pause];
}

- (void)resume
{
    [self.operation resume];
}

- (BOOL)canResume
{
    return self.operation != nil;
}

- (void)cancel
{
    [self.operation cancel];
}

@end
