//
//  SMContact.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/3/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContact.h"
#import "SMApiClient.h"
#import "SMFormDescription.h"
#import "SMServerError.h"

@implementation SMContact
@synthesize title=_title,
text=_text,
coordinates=_coordinates,
backgroundUrl=_backgroundUrl,
navbarIcon=_navbarIcon,
form=_form;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        _title = [attributes objectForKey:kModelContactPageTitle];
        _text = [attributes objectForKey:kModelContactPageText];
        
        NSArray *maps = [attributes objectForKey:kModelContactPageCoordinates];
        if ([maps isKindOfClass:[NSArray class]] && [maps count] == 2) {
            _coordinates = CLLocationCoordinate2DMake([[maps objectAtIndex:0] floatValue], [[maps objectAtIndex:1] floatValue]);
        }
        
        NSDictionary *formDict = [attributes objectForKey:kModelContactFormDescription];
        if ([formDict isKindOfClass:[NSDictionary class]]) {
            _form = [[SMFormDescription alloc] initWithDictionary:formDict];
        }
        
        _extra = [attributes objectForKey:kModelContactPageExtra];
        
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
    if (self.coordinates.latitude == 0 && self.coordinates.longitude == 0) 
        return NO;
    
    return (self.coordinates.latitude >= -90.0f && self.coordinates.latitude <= 90.0f && self.coordinates.longitude >= -180.0f && self.coordinates.longitude <= 180.0f);
}

+ (BOOL)isValidResponse:(id)response
{
    if (![response isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Contact response needs to be a dictionary");
        return NO;
    }
    
    /*if ([response objectForKey:kModelContactPageCoordinates] && ![[response objectForKey:kModelContactPageCoordinates] isKindOfClass:[NSArray class]]) {
        return NO;
    }*/
    
    return ([response objectForKey:kModelContactPageTitle] &&
            [response objectForKey:kModelContactPageText] &&
            [response objectForKey:kModelContactPageCoordinates] &&
            [response objectForKey:kModelContactFormDescription] &&
            [response objectForKey:kModelContactPageExtra] &&
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
