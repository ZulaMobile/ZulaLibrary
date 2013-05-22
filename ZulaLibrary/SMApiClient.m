//
//  SMApiClient.m
//  StarPet
//
//  Created by Suleyman Melikoglu on 3/7/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMApiClient.h"
#import "AFJSONRequestOperation.h"

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

+ (NSURL*)baseUrl
{
    
#ifdef DEBUG_APP
    return [NSURL URLWithString:@"http://localhost:8000/"];
#else
    /*
     NSDictionary* serverInfo = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"rest server"];
     NSString* baseUrl = [serverInfo objectForKey:@"url"];
     return [NSURL URLWithString:baseUrl];
     */
    return [NSURL URLWithString:@"http://www.zulamobile.com/"];
#endif
    
    
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
        // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        //[operation setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil]];
        [self setParameterEncoding:AFJSONParameterEncoding];
        
    }
    return self;
}
@end
