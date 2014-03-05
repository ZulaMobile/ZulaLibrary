//
//  SMDownloadSession.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 23/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

/**
 *  Download session is a wrapper around a http request operation
 *  This class is supposed to give pause and resume behaviors of a download session.
 */
@interface SMDownloadSession : NSObject

- (id)initWithRequestOperation:(AFHTTPRequestOperation *)anOperation;

- (void)pause;

- (void)resume;

- (BOOL)canResume;

- (void)cancel;

@end
