//
//  SMAppDescriptionRestApiDataSource.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMAppDescriptionRestApiDataSource.h"
#import "SMApiClient.h"
#import "AFHTTPRequestOperation.h"
#import "SMServerError.h"

@implementation SMAppDescriptionRestApiDataSource

- (void)fetchAppDescriptionWithCompletion:(void (^)(NSDictionary *, NSError *))completion
{
    // fetch data from datasource
    [[SMApiClient sharedClient] getPath:@"/api/v1/meta/app-description"
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        // successful response
        
        // validate data
        if(![SMAppDescriptionRestApiDataSource isValidData:responseObject]) {
            NSError *err = [[NSError alloc] initWithDomain:@"zulamobile" code:500 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Invalid response data", @"description", nil]];
            if (completion) {
                completion(nil, err);
            }
            return;
        }
        
        NSDictionary *response = (NSDictionary *)responseObject;
        if (completion) {
            completion(response, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // error
        SMServerError *err = [[SMServerError alloc] initWithOperation:operation];
        if (completion) {
            completion(nil, err);
        }
    }];
}

@end
