//
//  SMContact.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/3/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContact.h"
#import "SMApiClient.h"

@implementation SMContact
@synthesize title=_title,
text=_text,
coordinates=_coordinates,
backgroundUrl=_backgroundUrl,
navbarIcon=_navbarIcon;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        _title = [attributes objectForKey:kModelContactPageTitle];
        _text = [attributes objectForKey:kModelContactPageText];
        
        NSArray *maps = [attributes objectForKey:kModelContactPageCoordinates];
        if ([maps count] == 2) {
            _coordinates = CLLocationCoordinate2DMake([[maps objectAtIndex:0] floatValue], [[maps objectAtIndex:1] floatValue]);
        }
        
        NSString *backgroundImageUrlString = [attributes objectForKey:kModelContactPageBackgroundImageUrl];
        if (backgroundImageUrlString && ![backgroundImageUrlString isEqualToString:@""]) {
            _backgroundUrl = [NSURL URLWithString:backgroundImageUrlString];
        }
        
        NSString *navbarIconUrlString = [attributes objectForKey:kModelContactPageNavbarIcon];
        if (navbarIconUrlString && ![navbarIconUrlString isEqualToString:@""]) {
            _navbarIcon = [NSURL URLWithString:navbarIconUrlString];
        }
    }
    return self;
}

- (BOOL)hasCoordinates
{
    return (self.coordinates.latitude >= -90.0f && self.coordinates.latitude <= 90.0f && self.coordinates.longitude >= -180.0f && self.coordinates.longitude <= 180.0f);
}

+ (BOOL)isValidResponse:(id)response
{
    if (![response isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    if ([response objectForKey:kModelContactPageCoordinates] && ![[response objectForKey:kModelContactPageCoordinates] isKindOfClass:[NSArray class]]) {
        return NO;
    }
    
    return ([response objectForKey:kModelContactPageTitle] &&
            [response objectForKey:kModelContactPageText] &&
            [response objectForKey:kModelContactPageCoordinates] &&
            [response objectForKey:kModelContactPageBackgroundImageUrl] &&
            [response objectForKey:kModelContactPageNavbarIcon]);
}

+ (void)fetchWithURLString:(NSString *)urlString Completion:(void (^)(SMContact *, SMServerError *))completion
{
    [[SMApiClient sharedClient] getPath:urlString
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // validate response
         if (![SMContact isValidResponse:responseObject]) {
             SMServerError *err = [[SMServerError alloc] initWithDomain:@"zulamobile" code:502 userInfo:nil];
             if (completion) {
                 completion(nil, err);
             }
             return;
         }
         
         NSDictionary *response = (NSDictionary *)responseObject;
         SMContact *contentPage = [[SMContact alloc] initWithAttributes:response];
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