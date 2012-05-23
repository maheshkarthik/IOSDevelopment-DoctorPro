//
//  MQMultiPoint.h
//  mq_ios_sdk
//
//  Created by Erik Scrafford on 8/9/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQGeometry.h"
#import "MQShape.h"

///The base class for all overlays that consist of a series of coordinates.
@interface MQMultiPoint : MQShape {
  @protected
    NSUInteger m_count;
    MQMapPoint *m_points;
}

///number of points in the multipoint path
@property (nonatomic, readonly) NSUInteger pointCount;

///vertices of the multipoint path
@property (nonatomic, readonly) MQMapPoint *points;

/**coordinates of vertices
 * @param coords A C array of coordinate structs
 * @param range A range specifying which coordinates to retrieve.
 */
- (void)getCoordinates:(CLLocationCoordinate2D *)coords range:(NSRange)range;


@end
