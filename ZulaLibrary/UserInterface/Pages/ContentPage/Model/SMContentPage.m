//
//  SMContentPage.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContentPage.h"
#import "SMApiClient.h"


@implementation SMContentPage
@synthesize title = _title;
@synthesize text = _text;
@synthesize imageUrl = _imageUrl;
@synthesize backgroundUrl = _backgroundUrl;
@synthesize navbarIcon = _navbarIcon;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        _title = [attributes objectForKey:kModelContentPageTitle];
        _text = [attributes objectForKey:kModelContentPageText];
        
        NSString *imageUrlString = [attributes objectForKey:kModelContentPageImageUrl];
        if (imageUrlString && ![imageUrlString isEqualToString:@""]) {
            _imageUrl = [NSURL URLWithString:imageUrlString];
        }
        
        NSString *backgroundImageUrlString = [attributes objectForKey:kModelContentPageBackgroundImageUrl];
        if (backgroundImageUrlString && ![backgroundImageUrlString isEqualToString:@""]) {
            _backgroundUrl = [NSURL URLWithString:backgroundImageUrlString];
        }
        
        NSString *navbarIconUrlString = [attributes objectForKey:kModelContentPageNavbarIcon];
        if (navbarIconUrlString && ![navbarIconUrlString isEqualToString:@""]) {
            _navbarIcon = [NSURL URLWithString:navbarIconUrlString];
        }
    }
    return self;
}

+ (BOOL)isValidResponse:(id)response
{
    if (![response isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    return ([response objectForKey:kModelContentPageTitle] &&
            [response objectForKey:kModelContentPageText] &&
            [response objectForKey:kModelContentPageImageUrl] &&
            [response objectForKey:kModelContentPageBackgroundImageUrl] &&
            [response objectForKey:kModelContentPageNavbarIcon]);
}

+ (void)fetchWithURLString:(NSString *)urlString Completion:(void (^)(SMContentPage *, SMServerError *))completion
{
    [[SMApiClient sharedClient] getPath:urlString
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        // validate response
        if (![SMContentPage isValidResponse:responseObject]) {
            SMServerError *err = [[SMServerError alloc] initWithDomain:@"zulamobile" code:502 userInfo:nil];
            if (completion) {
                completion(nil, err);
            }
            return;
        }
        
        NSDictionary *response = (NSDictionary *)responseObject;
        SMContentPage *contentPage = [[SMContentPage alloc] initWithAttributes:response];
        if (completion) {
            completion(contentPage, nil);
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
