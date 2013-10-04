//
//  SMApiClient.h
//  StarPet
//
//  Created by Suleyman Melikoglu on 3/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <AFNetworking/AFHTTPClient.h>

@interface SMApiClient : AFHTTPClient

+ (SMApiClient*)sharedClient;
+ (NSURL*)baseUrl;

@end