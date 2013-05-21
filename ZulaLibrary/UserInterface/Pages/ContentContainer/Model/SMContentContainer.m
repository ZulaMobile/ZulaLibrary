//
//  SMContentContainer.m
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 5/21/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContentContainer.h"
#import "SMContentPage.h"
#import "SMApiClient.h"

@implementation SMContentContainer
@synthesize title=_title, components=_components;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        _title = [attributes objectForKey:kModelContentContainerTitle];
        
        NSArray *componentData = [attributes objectForKey:kModelContentContainerComponents];
        NSMutableArray *tmpComponents = [NSMutableArray arrayWithCapacity:[componentData count]];
        for (NSDictionary *contentData in componentData) {
            // create `SMContentPage` objects
            SMContentPage *content = [[SMContentPage alloc] initWithAttributes:contentData];
            [tmpComponents addObject:content];
        }
        _components = [NSArray arrayWithArray:tmpComponents];
    }
    return self;
}

+ (BOOL)isValidResponse:(id)response
{
    if (![response isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    if (!([response objectForKey:kModelContentContainerTitle] &&
        [response objectForKey:kModelContentContainerComponents])) {
        return NO;
    }
    
    if (![[response objectForKey:kModelContentContainerComponents] isKindOfClass:[NSArray class]]) {
        return NO;
    }
    
    return YES;
}

+ (void)fetchWithURLString:(NSString *)urlString completion:(void (^)(SMContentContainer *, SMServerError *))completion
{
    [[SMApiClient sharedClient] getPath:urlString
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // validate response
         if (![SMContentContainer isValidResponse:responseObject]) {
             SMServerError *err = [[SMServerError alloc] initWithDomain:@"zulamobile" code:502 userInfo:nil];
             if (completion) {
                 completion(nil, err);
             }
             return;
         }
         
         NSDictionary *response = (NSDictionary *)responseObject;
         SMContentContainer *contentContainer = [[SMContentContainer alloc] initWithAttributes:response];
         if (completion) {
             completion(contentContainer, nil);
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
