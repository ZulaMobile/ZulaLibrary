//
//  SMLogManager.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMLogManager.h"
#import <DDTTYLogger.h>
#import "SMUploadingLogFileManager.h"
#import "SMLogFileFormatter.h"

@interface SMLogManager()

@end

@implementation SMLogManager

- (void)start
{
    /* Compressing file manager and File Logger */
    /*
    SMUploadingLogFileManager *logFileManager = [[SMUploadingLogFileManager alloc] init];
	fileLogger = [[SMFileLogger alloc] initWithLogFileManager:logFileManager];
	fileLogger.maximumFileSize  = (1024 * 100);   //  100 KB
	fileLogger.rollingFrequency = (60 * 60 * 12);  // 12 Hours
	fileLogger.logFileManager.maximumNumberOfLogFiles = 4;
    [fileLogger setLogFormatter:[[SMLogFileFormatter alloc] init]];
     */
    
	/* Add Loggers */
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
	//[DDLog addLogger:fileLogger];
	
    /* Enable Colors */
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    UIColor *pink = [UIColor colorWithRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
    [[DDTTYLogger sharedInstance] setForegroundColor:pink backgroundColor:nil forFlag:LOG_FLAG_INFO];
    
    UIColor *gray = [UIColor colorWithRed:(221/255.0) green:(221/255.0) blue:(221/255.0) alpha:0.5];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:gray forFlag:LOG_FLAG_VERBOSE];
    
    // test it out
    /*
     DDLogError(@"this is my error desctiption");
    DDLogWarn(@"this is a warning");
    DDLogInfo(@"this is info");
    DDLogVerbose(@"User selected file:%@ withSize:%f ", @"/myfolder/sample.png", 2500.0);
     */
}

@end
