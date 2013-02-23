//
//  SMComponentDescription.h
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMComponentDescription : NSObject

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *slug;

@property (nonatomic, strong) NSDictionary *appearance;

@end
