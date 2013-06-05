//
//  SMImageGallery.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMImageGallery.h"
#import "SMApiClient.h"
#import "SMServerError.h"

@implementation SMImageGallery
@synthesize title=_title, images=_images, backgroundUrl=_backgroundUrl, navbarIcon=_navbarIcon;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _title = [attributes objectForKey:kModelImageGalleryTitle];
        
        if ([[attributes objectForKey:kModelImageGalleryImages] isKindOfClass:[NSArray class]]) {
            NSArray *imagesFetched = [attributes objectForKey:kModelImageGalleryImages];
            NSMutableArray *imagesArr = [NSMutableArray arrayWithCapacity:[imagesFetched count]];
            for (NSString *imageUrl in imagesFetched) {
                [imagesArr addObject:[NSURL URLWithString:imageUrl]];
            }
            _images = [NSArray arrayWithArray:imagesArr];
        }
        
        NSString *backgroundImageUrlString = [attributes objectForKey:kModelImageGalleryBackgroundImage];
        if (backgroundImageUrlString && ![backgroundImageUrlString isEqualToString:@""]) {
            _backgroundUrl = [NSURL URLWithString:backgroundImageUrlString];
        }
        
        NSString *navbarIconUrlString = [attributes objectForKey:kModelImageGalleryNavbarIcon];
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
    
    if (!([response objectForKey:kModelImageGalleryTitle] &&
          [response objectForKey:kModelImageGalleryImages] &&
          [response objectForKey:kModelImageGalleryBackgroundImage] &&
          [response objectForKey:kModelImageGalleryNavbarIcon])) {
        return NO;
    }
    
    if (![[response objectForKey:kModelImageGalleryImages] isKindOfClass:[NSArray class]]) {
        return NO;
    }
    
    return YES;
}

+ (void)fetchWithURLString:(NSString *)urlString
                completion:(void (^)(SMImageGallery *, SMServerError *))completion
{
    [[SMApiClient sharedClient] getPath:urlString
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // validate response
         if (![SMImageGallery isValidResponse:responseObject]) {
             SMServerError *err = [[SMServerError alloc] initWithDomain:@"zulamobile" code:502 userInfo:nil];
             if (completion) {
                 completion(nil, err);
             }
             return;
         }
         
         NSDictionary *response = (NSDictionary *)responseObject;
         SMImageGallery *model = [[SMImageGallery alloc] initWithAttributes:response];
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
