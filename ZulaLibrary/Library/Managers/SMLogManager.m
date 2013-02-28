//
//  SMLogManager.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMLogManager.h"
#import <DDLog.h>
#import <DDTTYLogger.h>
#import "SMUploadingLogFileManager.h"
#import "SMLogFileFormatter.h"

#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_WARN;
#endif

@interface SMLogManager()
- (void)writeLogMessages:(NSTimer *)aTimer;
@end

@implementation SMLogManager

- (void)start
{
    /* Compressing file manager and File Logger */
    SMUploadingLogFileManager *logFileManager = [[SMUploadingLogFileManager alloc] init];
	
	fileLogger = [[SMFileLogger alloc] initWithLogFileManager:logFileManager];

	fileLogger.maximumFileSize  = (1024 * 100);   //  100 KB
	fileLogger.rollingFrequency = (60 * 60 * 12);  // 12 Hours
	fileLogger.logFileManager.maximumNumberOfLogFiles = 4;
    [fileLogger setLogFormatter:[[SMLogFileFormatter alloc] init]];

	/* Add Loggers */
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
	[DDLog addLogger:fileLogger];
	
	[NSTimer scheduledTimerWithTimeInterval:1.0
	                                 target:self
	                               selector:@selector(writeLogMessages:)
	                               userInfo:nil
	                                repeats:YES];
    
    /* Enable Colors */
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    UIColor *pink = [UIColor colorWithRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
    [[DDTTYLogger sharedInstance] setForegroundColor:pink backgroundColor:nil forFlag:LOG_FLAG_INFO];
    
    UIColor *gray = [UIColor colorWithRed:(221/255.0) green:(221/255.0) blue:(221/255.0) alpha:0.5];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:gray forFlag:LOG_FLAG_VERBOSE];
    
    // test it out
    DDLogError(@"this is my error desctiption");
    DDLogWarn(@"this is a warning");
    DDLogInfo(@"this is info");
    DDLogVerbose(@"User selected file:%@ withSize:%f ", @"/myfolder/sample.png", 2500.0);
}

- (void)writeLogMessages:(NSTimer *)aTimer
{
	DDLogVerbose(@"I like cheese");
}

@end
