//
//  SMContainer.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/11/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContainer.h"
#import "SMComponentDescription.h"
#import "SMApiClient.h"
#import "SMServerError.h"

@implementation SMContainer
@synthesize title=_title, components=_components, navbarIcon=_navbarIcon;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        _title = [attributes objectForKey:kModelContainerPageTitle];
        
        NSString *navbarIconUrlString = [attributes objectForKey:kModelPageNavigationBarIcon];
        if (navbarIconUrlString && ![navbarIconUrlString isEqualToString:@""]) {
            _navbarIcon = [NSURL URLWithString:navbarIconUrlString];
        }
        
        // components
        NSMutableArray *components_tmp_arr = [NSMutableArray array];
        NSArray *components_arr = [attributes objectForKey:kModelPageComponents];
        if ([components_arr isKindOfClass:[NSArray class]]) {
            for (NSDictionary *component_dict in components_arr) {
                [components_tmp_arr addObject:[[SMComponentDescription alloc] initWithAttributes:component_dict]];
            }
            _components = [NSArray arrayWithArray:components_tmp_arr];
        }
    }
    return self;
}

+ (BOOL)isValidResponse:(id)response
{
    if (![response isKindOfClass:[NSDictionary class]]) {
        DDLogInfo(@"Container response needs to be a dictionary");
        return NO;
    }
    
    return ([response objectForKey:kModelContainerPageTitle] &&
            [response objectForKey:kModelPageComponents] &&
            [response objectForKey:kModelPageNavigationBarIcon]);
}

+ (void)fetchWithURLString:(NSString *)urlString completion:(void (^)(SMContainer *, SMServerError *))completion
{
    [[SMApiClient sharedClient] getPath:urlString
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // validate response
         if (![SMContainer isValidResponse:responseObject]) {
             SMServerError *err = [[SMServerError alloc] initWithDomain:@"zulamobile" code:502 userInfo:nil];
             if (completion) {
                 completion(nil, err);
             }
             return;
         }
         
         NSDictionary *response = (NSDictionary *)responseObject;
         SMContainer *contentPage = [[SMContainer alloc] initWithAttributes:response];
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
