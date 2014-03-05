//
//  ProductDetail.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/30/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMProductDetail.h"
#import "SMApiClient.h"

@implementation SMProductDetail
@synthesize title=_title;
@synthesize text=_text;
@synthesize images=_images;
@synthesize backgroundUrl=_backgroundUrl;
@synthesize navbarIcon=_navbarIcon;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _title = [attributes objectForKey:kModelProductDetailTitle];
        _text = [attributes objectForKey:kModelProductDetailText];
        
        if ([[attributes objectForKey:kModelProductDetailImages] isKindOfClass:[NSArray class]]) {
            NSArray *imagesFetched = [attributes objectForKey:kModelProductDetailImages];
            NSMutableArray *imagesArr = [NSMutableArray arrayWithCapacity:[imagesFetched count]];
            for (NSString *imageUrl in imagesFetched) {
                [imagesArr addObject:[NSURL URLWithString:imageUrl]];
            }
            _images = [NSArray arrayWithArray:imagesArr];
        }
        
        NSString *backgroundImageUrlString = [attributes objectForKey:kModelProductDetailBackgroundImage];
        if (backgroundImageUrlString && ![backgroundImageUrlString isEqualToString:@""]) {
            _backgroundUrl = [NSURL URLWithString:backgroundImageUrlString];
        }
        
        NSString *navbarIconUrlString = [attributes objectForKey:kModelProductDetailNavbarIcon];
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
    
    if (!([response objectForKey:kModelProductDetailTitle] &&
          [response objectForKey:kModelProductDetailImages] &&
          [response objectForKey:kModelProductDetailBackgroundImage] &&
          [response objectForKey:kModelProductDetailNavbarIcon] &&
          [response objectForKey:kModelProductDetailText])) {
        return NO;
    }
    
    if (![[response objectForKey:kModelProductDetailImages] isKindOfClass:[NSArray class]]) {
        return NO;
    }
    
    return YES;
}

+ (void)fetchWithURLString:(NSString *)urlString
                completion:(void (^)(SMProductDetail *, SMServerError *))completion
{
    [[SMApiClient sharedClient] getPath:urlString
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // validate response
         if (![SMProductDetail isValidResponse:responseObject]) {
             SMServerError *err = [[SMServerError alloc] initWithDomain:@"zulamobile" code:502 userInfo:nil];
             if (completion) {
                 completion(nil, err);
             }
             return;
         }
         
         NSDictionary *response = (NSDictionary *)responseObject;
         SMProductDetail *model = [[SMProductDetail alloc] initWithAttributes:response];
         if (completion) {
             completion(model, nil);
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
