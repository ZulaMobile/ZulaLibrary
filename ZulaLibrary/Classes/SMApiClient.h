//
//  SMApiClient.h
//  StarPet
//
//  Created by Suleyman Melikoglu on 3/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

@class SMDownloadSession, AFHTTPRequestOperation;

@interface SMApiClient : NSObject

+ (SMApiClient*)sharedClient;
- (id)initWithBaseURL:(NSURL *)baseUrl;
+ (NSURL*)baseUrl;

- (SMDownloadSession *)downloadToPath:(NSString *)downloadPath
                              getPath:(NSString *)getPath
                           parameters:(NSDictionary *)parameters
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *responseObject, NSError *error))failure
                             progress:(void(^)(float percentage))progress;

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end