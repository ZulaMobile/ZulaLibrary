//
//  SMFormModel.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/10/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMFormDescription;

/**
 FormModel is the back-end integration of forms.
 */
@interface SMFormModel : NSObject

/**
 submits the form to the default back-end
 */
+ (void)submitFormDescription:(SMFormDescription *)formDescription
                  toUrlString:(NSString *)urlString
                   completion:(void(^)(NSError *error))completion;

@end
