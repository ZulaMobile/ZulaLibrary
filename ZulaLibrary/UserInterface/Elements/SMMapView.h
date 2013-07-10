//
//  SMMapView.h
//  ZulaLibrary
//
//  Created by Suleyman Melikoglu on 6/4/13.
//  Copyright (c) 2013 laplacesdemon. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "SMViewElement.h"

@protocol SMMapViewDelegate;

@interface SMMapView : MKMapView <SMViewElement>

@property (nonatomic, weak) id<SMMapViewDelegate> routeButtonDelegate;

@end

@protocol SMMapViewDelegate <NSObject>
- (void)onRouteButton:(SMMapView *)mapView;
@end
