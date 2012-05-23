//
//  MQPolyline.h
//  mq_ios_sdk
//
//  Created by Erik Scrafford on 8/9/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQMultiPoint.h"
#import "MQOverlay.h"

/** MQPolyine is an overlay expressed as a series of connected coordinates that are not closed
 *
 */
@interface MQPolyline : MQMultiPoint <MQOverlay> {
    
}

/**Create a polyline object with a collection of coordinates
 * @param coords c array of CLLocationCoordinate2D coords
 * @param count number of coords in array
 * @return new polyline object
 */
+ (MQPolyline *)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count;

/**Create a polyline object with a collection of map points
 * @param points c array of map points
 * @param count number of coords in array
 * @return polyline object
 */
+ (MQPolyline *)polylineWithPoints:(MQMapPoint *)points count:(NSUInteger)count;


@end
