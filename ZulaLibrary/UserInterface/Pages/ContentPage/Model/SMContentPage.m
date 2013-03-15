//
//  SMContentPage.m
//  AppCreatorLibrary
//
//  Created by Suleyman Melikoglu on 2/5/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import "SMContentPage.h"
#import "SMApiClient.h"


@implementation SMContentPage
@synthesize title = _title;
@synthesize text = _text;
@synthesize imageUrl = _imageUrl;
@synthesize backgroundUrl = _backgroundUrl;

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        _title = [attributes objectForKey:kModelContentPageTitle];
        _text = [attributes objectForKey:kModelContentPageText];
        
        NSString *imageUrlString = [attributes objectForKey:kModelContentPageImageUrl];
        if (imageUrlString && ![imageUrlString isEqualToString:@""]) {
            _imageUrl = [NSURL URLWithString:imageUrlString];
        }
        
        NSString *backgroundImageUrlString = [attributes objectForKey:kModelContentPageBackgroundImageUrl];
        if (backgroundImageUrlString && ![backgroundImageUrlString isEqualToString:@""]) {
            _backgroundUrl = [NSURL URLWithString:backgroundImageUrlString];
        }
    }
    return self;
}

+ (BOOL)isValidResponse:(id)response
{
    if (![response isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    return ([response objectForKey:kModelContentPageTitle] &&
            [response objectForKey:kModelContentPageText] &&
            [response objectForKey:kModelContentPageImageUrl] &&
            [response objectForKey:kModelContentPageBackgroundImageUrl]);
}

+ (void)fetchWithURLString:(NSString *)urlString Completion:(void (^)(SMContentPage *, SMServerError *))completion
{
    [[SMApiClient sharedClient] getPath:urlString
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        // validate response
        if (![SMContentPage isValidResponse:responseObject]) {
            SMServerError *err = [[SMServerError alloc] initWithDomain:@"zulamobile" code:502 userInfo:nil];
            if (completion) {
                completion(nil, err);
            }
            return;
        }
        
        NSDictionary *response = (NSDictionary *)responseObject;
        SMContentPage *contentPage = [[SMContentPage alloc] initWithAttributes:response];
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

+ (void)fetchWithCompletionSample:(void (^)(SMContentPage *, NSError *))completion
{
    // sample images:
    // http://folioflip.foliothemes.com/wp-content/uploads/2009/11/guitar2-320x150.jpg
    // http://www.marcjulienhomes.com/wp-content/uploads/2011/03/0040-320x150.jpg
    // http://www.emobilez.com/wallpapers/data/media/298/nuclear_iphone_wallpapers.jpg
    // http://www.dailymobile.net/wp-content/uploads/2009/02/iphone-wallpaper-087.jpg
    // http://www.c4rlh.com/mobile-phone/free-wallpapers/signs/cold-apple-logo.jpg
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"Sample Title", @"title",
                                @"http://folioflip.foliothemes.com/wp-content/uploads/2009/11/guitar2-320x150.jpg", @"image",
                                @"http://www.c4rlh.com/mobile-phone/free-wallpapers/signs/cold-apple-logo.jpg", @"bg_image",
                                @"<html><body style='color:white;padding:none;margin:none;'>Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.Donec id elit non mi porta gravida at eget metus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Donec sed odio dui.</body></html>", @"text",
                                nil];
    SMContentPage *contentPage = [[SMContentPage alloc] initWithAttributes:attributes];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (completion) {
            completion(contentPage, nil);
        }
    });
    
}

@end
