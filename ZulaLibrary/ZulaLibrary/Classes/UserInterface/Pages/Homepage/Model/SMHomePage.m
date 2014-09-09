//
//  SMHomePage.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 2/28/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMHomePage.h"
#import "ZulaLibrary.h"
#import "SMApiClient.h"

@implementation SMHomePage
@synthesize logoUrl = _logoUrl;
@synthesize backgroundUrl = _backgroundUrl;
@synthesize components = _components;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        NSString *logoUrl = [attributes objectForKey:kModelHomePageImageLogo];
        if (logoUrl && ![logoUrl isEqualToString:@""]) {
            _logoUrl = [NSURL URLWithString:logoUrl];
        }
        
        NSString *backgroundImageUrlString = [attributes objectForKey:kModelHomePageBackgroundImageUrl];
        if (backgroundImageUrlString && ![backgroundImageUrlString isEqualToString:@""]) {
            _backgroundUrl = [NSURL URLWithString:backgroundImageUrlString];
        }
        
        NSArray *theComponents = [attributes objectForKey:kModelHomePageComponents];
        if (theComponents && [theComponents isKindOfClass:[NSArray class]]) {
            _components = theComponents;
        }
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
