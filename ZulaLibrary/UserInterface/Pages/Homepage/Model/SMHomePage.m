//
//  SMHomePage.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMHomePage.h"
#import "SMApiClient.h"

@implementation SMHomePage
@synthesize logoUrl = _logoUrl;
@synthesize backgroundUrl = _backgroundUrl;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _logoUrl = [NSURL URLWithString:[attributes objectForKey:kModelHomePageImageLogo]];
        _backgroundUrl = [NSURL URLWithString:[attributes objectForKey:kModelHomePageBackgroundImageUrl]];
    }
    return self;
}

+ (BOOL)isValidResponse:(id)response
{
    if (![response isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    return ([response objectForKey:kModelHomePageImageLogo] &&
            [response objectForKey:kModelHomePageBackgroundImageUrl]);
}

+ (void)fetchWithURLString:(NSString *)urlString completion:(void (^)(SMHomePage *, SMServerError *))completion
{
    [[SMApiClient sharedClient] getPath:urlString
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        // validate response
        if (![SMHomePage isValidResponse:responseObject]) {
            SMServerError *err = [[SMServerError alloc] initWithDomain:@"zulamobile" code:502 userInfo:nil];
            if (completion) {
                completion(nil, err);
            }
            return;
        }
        
        NSDictionary *response = (NSDictionary *)responseObject;
        SMHomePage *homepage = [[SMHomePage alloc] initWithAttributes:response];
        if (completion) {
            completion(homepage, nil);
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
