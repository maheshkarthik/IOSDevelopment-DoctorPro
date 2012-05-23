//
//  MQOverlay.h
//  mq_ios_sdk
//
//  Created by Erik Scrafford on 8/5/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQAnnotation.h"
#import "MQGeometry.h"


/**
 * Overlay protocol
 */
@protocol MQOverlay <MQAnnotation>

///The rectangle bounding the annotation in map points
@property (nonatomic, readonly) MQMapRect boundingMapRect;

///Coordinate of the center of the overlay
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


@optional
///Check to see if the overlay intersects another mapRect
- (BOOL)intersectsMapRect:(MQMapRect)mapRect;

@end
