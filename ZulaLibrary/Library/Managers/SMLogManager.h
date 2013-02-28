//
//  SMLogManager.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMFileLogger.h"

@interface SMLogManager : NSObject
{
    @private
    SMFileLogger *fileLogger;
}
- (void)start;

@end
