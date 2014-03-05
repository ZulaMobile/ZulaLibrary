//
//  SMWeb.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/12/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMWeb.h"
#import "SMApiClient.h"
#import "SMServerError.h"

@implementation SMWeb
@synthesize title=_title, url=_url;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        _title = [attributes objectForKey:kModelWebPageTitle];
        
        NSString *urlString = [attributes objectForKey:kModelWebPageUrl];
        if (urlString && ![urlString isEqualToString:@""]) {
            _url = [NSURL URLWithString:urlString];
        }
        
        NSString *navbarIconUrlString = [attributes objectForKey:kModelWebPageNavbarIcon];
        if (navbarIconUrlString && ![navbarIconUrlString isEqualToString:@""]) {
            _navbarIcon = [NSURL URLWithString:navbarIconUrlString];
        }
    }
    return self;
}

+ (BOOL)isValidResponse:(id)response
{
    if (![response isKindOfClass:[NSDictionary class]]) {
        DDLogInfo(@"Web component response needs to be a dictionary");
        return NO;
    }
    
    /*if ([response objectForKey:kModelContactPageCoordinates] && ![[response objectForKey:kModelContactPageCoordinates] isKindOfClass:[NSArray class]]) {
     return NO;
     }*/
    
    return ([response objectForKey:kModelWebPageTitle] &&
            [response objectForKey:kModelWebPageUrl] &&
            [response objectForKey:kModelWebPageNavbarIcon]);
}

+ (void)fetchWithURLString:(NSString *)urlString completion:(void (^)(SMWeb *web, SMServerError *error))completion
{
    [[SMApiClient sharedClient] getPath:urlString
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // validate response
         if (![SMWeb isValidResponse:responseObject]) {
             SMServerError *err = [[SMServerError alloc] initWithDomain:@"zulamobile" code:502 userInfo:nil];
             if (completion) {
                 completion(nil, err);
             }
             return;
         }
         
         NSDictionary *response = (NSDictionary *)responseObject;
         SMWeb *webPage = [[SMWeb alloc] initWithAttributes:response];
         if (completion) {
             completion(webPage, nil);
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
