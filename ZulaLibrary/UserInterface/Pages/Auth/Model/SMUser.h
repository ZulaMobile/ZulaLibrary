//
//  SMUser.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 7/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMModel.h"

@class SMServerError;

// data structure constants
#define kModelUserToken @"token"
#define kModelUserBaseUrl @"base_url"
#define kModelUserVersion @"version"

@interface SMUser : SMModel

@property (nonatomic, readonly) NSString *token;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, readonly) NSString *baseUrl;
@property (nonatomic, readonly) NSString *version;

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (BOOL)isValidResponse:(id)response;
+ (void)logInWithUsername:(NSString *)username password:(NSString *)password completion:(void(^)(SMUser *user, SMServerError *error))completion;


@end
