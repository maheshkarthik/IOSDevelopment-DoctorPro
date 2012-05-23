//
//  MQCircle.h
//  mq_ios_sdk
//
//  Created by Erik Scrafford on 8/9/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQShape.h"
#import "MQOverlay.h"
#import "MQAnnotation.h"
#import "MQGeometry.h"

/** MQCircle is a circular overlay that takes a center coordinate (lat/lon) and a radius in meters. 
 *
 */
@interface MQCircle : MQShape <MQOverlay, MQAnnotation, NSCopying> {
    MQMapRect m_boundingMapRect;
    CLLocationCoordinate2D m_coordinate;
    CLLocationDistance m_radius;
}

///bounding region for circle
@property (nonatomic, readonly) MQMapRect boundingMapRect;

///Center coordinate for circle
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

///radius for circle
@property (nonatomic, readonly) CLLocationDistance radius;

/**Create a circle object using a center coordinate and radius
 * @param coord center coordinate for circle
 * @param radius radius of circle
 * @return new MQCircle object
 */
+ (MQCircle *)circleWithCenterCoordinate:(CLLocationCoordinate2D)coord radius:(CLLocationDistance)radius;

/**Create a circle object using a bounding region
 * @param mapRect bounding region containing circle
 * @return new MQCircle object
 */
+ (MQCircle *)circleWithMapRect:(MQMapRect)mapRect;

@end
