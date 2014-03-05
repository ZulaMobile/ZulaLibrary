//
//  SMFileLogger.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMFileLogger.h"

@implementation SMFileLogger

- (void)logMessage:(DDLogMessage *)logMessage
{
    if (logMessage->logFlag <= 2) {
        [super logMessage:logMessage];
    }
}

@end
