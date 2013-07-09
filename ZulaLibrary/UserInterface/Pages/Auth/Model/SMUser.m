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
        
        // persists
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:attributes forKey:@"user"];
        [defaults synchronize];
    }
    return self;
}

+ (SMUser *)currentUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults objectForKey:@"user"];
    if (dict) {
        return [[SMUser alloc] initWithAttributes:dict];
    } else {
        return nil;
    }
}

- (void)logOut
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"user"];
    [defaults synchronize];
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
    NSString *defaultApiUrl = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"default_api_url"];
    SMApiClient *client = [[SMApiClient alloc] initWithBaseURL:[NSURL URLWithString:defaultApiUrl]];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:username, @"username", password, @"password", nil];
    [client postPath:@"api/v1/login/"
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
         
         // set defaults
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setValue:[user baseUrl] forKey:@"api_url"];
         [defaults synchronize];
         
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
