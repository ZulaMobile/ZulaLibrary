//
//  SMApiClient.m
//  StarPet
//
//  Created by Suleyman Melikoglu on 3/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <AFNetworking/AFHTTPClient.h>
#import "SMApiClient.h"
#import "AFJSONRequestOperation.h"
#import "SMDownloadSession.h"

@interface SMApiClient ()
@property (nonatomic, strong) AFHTTPClient *client;
@end

@implementation SMApiClient

// singleton instance
+ (SMApiClient*)sharedClient
{
    static SMApiClient* _sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SMApiClient alloc] initWithBaseURL:[SMApiClient baseUrl]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)baseUrl
{
    if (!baseUrl) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.client = [[AFHTTPClient alloc] initWithBaseURL:baseUrl];
        [self.client registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
        // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
        [self.client setDefaultHeader:@"Accept" value:@"application/json"];
        //[operation setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil]];
        [self.client setParameterEncoding:AFJSONParameterEncoding];
        
    }
    return self;
}

+ (NSURL*)baseUrl
{
#ifdef DEBUG_APP
    //return [NSURL URLWithString:@"http://localhost:8000/"];
    //return [NSURL URLWithString:@"http://lotb.zulamobile.com/"];
    //return [NSURL URLWithString:@"http://192.168.0.12:8000/"];
#endif
    
    NSString *apiUrl;
    
    // check if base url exists in defaults. Preview app sets base url on defaults
    /*
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    apiUrl = [defaults objectForKey:@"api_url"];
    if (apiUrl) {
        return [NSURL URLWithString:apiUrl];
    }
     */
    
    // otherwise fetch if from the plist
    apiUrl = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"api_url"];
    if (apiUrl) {
        return [NSURL URLWithString:apiUrl];
    }
    
    // no api url, show an error
    [[NSNotificationCenter defaultCenter] postNotificationName:kMalformedAppNotification
                                                        object:nil
                                                      userInfo:nil];
    
    // return to default 
    return [NSURL URLWithString:@"http://www.zulamobile.com/"];
}

- (SMDownloadSession *)downloadToPath:(NSString *)downloadPath
               getPath:(NSString *)getPath
            parameters:(NSDictionary *)parameters
               success:(void (^)(AFHTTPRequestOperation *, id))success
               failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
              progress:(void(^)(float percentage))progress
{
    
    NSMutableURLRequest* rq = [self.client requestWithMethod:@"GET"
                                                     path:getPath
                                               parameters:parameters];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:rq];
    
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:downloadPath append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        // progress
        float complete = (float)totalBytesRead / (float)totalBytesExpectedToRead;
        if (progress) {
            progress(complete);
        }
    }];
    
    __block id weakOperation = self;
    [operation setShouldExecuteAsBackgroundTaskWithExpirationHandler:^{
        AFHTTPRequestOperation *strongOperation = weakOperation;
        [strongOperation pause];
    }];
    
    [operation start];
    
    return [[SMDownloadSession alloc] initWithRequestOperation:operation];
}

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [self.client getPath:path parameters:parameters success:success failure:failure];
}

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [self.client postPath:path parameters:parameters success:success failure:failure];
}

@end
