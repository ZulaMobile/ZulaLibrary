//
//  SMVideoGallery.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/29/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMVideoGallery.h"
#import "SMApiClient.h"
#import "SMServerError.h"

@implementation SMVideoGallery
@synthesize title=_title, videos=_videos, backgroundUrl=_backgroundUrl, navbarIcon=_navbarIcon;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _title = [attributes objectForKey:kModelVideoGalleryTitle];
        
        if ([[attributes objectForKey:kModelVideoGalleryVideos] isKindOfClass:[NSArray class]]) {
            NSArray *fetchedVideos = [attributes objectForKey:kModelVideoGalleryVideos];
            NSMutableArray *videosArr = [NSMutableArray arrayWithCapacity:[fetchedVideos count]];
            for (NSDictionary *videoDict in fetchedVideos) {
                SMVideo *video = [[SMVideo alloc] initWithAttributes:videoDict];
                [videosArr addObject:video];
            }
            _videos = [NSArray arrayWithArray:videosArr];
        }
        
        NSString *backgroundImageUrlString = [attributes objectForKey:kModelVideoGalleryBackgroundImage];
        if (backgroundImageUrlString && ![backgroundImageUrlString isEqualToString:@""]) {
            _backgroundUrl = [NSURL URLWithString:backgroundImageUrlString];
        }
        
        NSString *navbarIconUrlString = [attributes objectForKey:kModelVideoGalleryNavbarIcon];
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
    
    if (!([response objectForKey:kModelVideoGalleryVideos] &&
          [response objectForKey:kModelVideoGalleryTitle] &&
          [response objectForKey:kModelVideoGalleryNavbarIcon] &&
          [response objectForKey:kModelVideoGalleryBackgroundImage])) {
        return NO;
    }
    
    if (![[response objectForKey:kModelVideoGalleryVideos] isKindOfClass:[NSArray class]]) {
        return NO;
    }
    
    return YES;
}

+ (void)fetchWithURLString:(NSString *)urlString completion:(void (^)(SMVideoGallery *, SMServerError *))completion
{
    [[SMApiClient sharedClient] getPath:urlString
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // validate response
         if (![SMVideoGallery isValidResponse:responseObject]) {
             SMServerError *err = [[SMServerError alloc] initWithDomain:@"zulamobile" code:502 userInfo:nil];
             if (completion) {
                 completion(nil, err);
             }
             return;
         }
         
         NSDictionary *response = (NSDictionary *)responseObject;
         SMVideoGallery *model = [[SMVideoGallery alloc] initWithAttributes:response];
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

@implementation SMVideo
@synthesize title=_title, url=_url, description=_description;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _title = [attributes objectForKey:kModelVideoTitle];
        _description = [attributes objectForKey:kModelVideoDescription];
        
        NSString *urlString = [attributes objectForKey:kModelVideoUrl];
        if (urlString && ![urlString isEqualToString:@""]) {
            _url = [NSURL URLWithString:urlString];
        }
    }
    return self;
}

@end
