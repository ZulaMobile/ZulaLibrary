//
//  SMUser.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 7/8/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMUser.h"
#import "SMApiClient.h"
#import "SMServerError.h"

@implementation SMUser
@synthesize token=_token, username=_username, baseUrl=_baseUrl, version=_version;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _token = [attributes objectForKey:kModelUserToken];
        _baseUrl = [attributes objectForKey:kModelUserBaseUrl];
        _version = [attributes objectForKey:kModelUserVersion];
    }
    return self;
}

+ (BOOL)isValidResponse:(id)response
{
    if (![response isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    return ([response objectForKey:kModelUserToken] &&
            [response objectForKey:kModelUserBaseUrl] &&
            [response objectForKey:kModelUserVersion]);
}

+ (void)logInWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(SMUser *, SMServerError *))completion
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:username, @"username", password, @"password", nil];
    [[SMApiClient sharedClient] postPath:@"http://localhost:8000/api/v1/login/"
                              parameters:params
                                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // validate response
         if (![SMUser isValidResponse:responseObject]) {
             SMServerError *err = [[SMServerError alloc] initWithDomain:@"zulamobile" code:502 userInfo:nil];
             if (completion) {
                 completion(nil, err);
             }
             return;
         }
         
         NSDictionary *response = (NSDictionary *)responseObject;
         SMUser *user = [[SMUser alloc] initWithAttributes:response];
         [user setUsername:username];
         if (completion) {
             completion(user, nil);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         // failure
         SMServerError *err = [[SMServerError alloc] initWithOperation:operation];
         if (completion) {
             completion(nil, err);
         }
     }];
}

@end
