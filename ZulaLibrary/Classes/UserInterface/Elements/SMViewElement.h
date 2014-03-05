//
//  SMViewElement.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/23/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMViewElement <NSObject>

/**
 Apply the appearance key-value settings that is fetched from the server
 If an key for the setting is not found, revert to the default setting
 */
- (void)applyAppearances:(NSDictionary *)appearances;

@end
