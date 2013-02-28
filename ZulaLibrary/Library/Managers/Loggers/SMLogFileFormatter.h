//
//  SMLogFileFormatter.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "DDFileLogger.h"
#import <DDLog.h>

@interface SMLogFileFormatter : NSObject <DDLogFormatter>
{
	NSDateFormatter *dateFormatter;
}

- (id)init;
- (id)initWithDateFormatter:(NSDateFormatter *)dateFormatter;

@end
