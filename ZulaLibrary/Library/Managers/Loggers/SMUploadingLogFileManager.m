//
//  SMUploadingLogFileManager.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMUploadingLogFileManager.h"

@implementation SMUploadingLogFileManager

- (void)didRollAndArchiveLogFile:(NSString *)logFilePath
{
    // compress the file first
    [super didRollAndArchiveLogFile:logFilePath];
    
    // upload the file
    // @todo
}

- (void)logMessage:(DDLogMessage *)logMessage
{
    /*
	if (logMessage.logFlag <= 2) {
        [super logMe]
    }*/
}

@end
