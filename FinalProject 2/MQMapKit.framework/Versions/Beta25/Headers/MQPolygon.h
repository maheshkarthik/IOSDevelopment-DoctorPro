//
//  MQPolygon.h
//  mq_ios_sdk
//
//  Created by Erik Scrafford on 8/9/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQGeometry.h"
#import "MQMultiPoint.h"
#import "MQOverlay.h"

///An overlay that is expressed as a series of coordinates that form a closed polygon. Inner polygons are masked out when a polygon overlay is drawn. Inner polygons need not be contained within the bounds of the "outer" polygon. Use Winding Rules to establish inner and outer polygons.
@interface MQPolygon : MQMultiPoint<MQOverlay> {
    
}

///Collections of polygons inside the encompassing polygon
@property (readonly) NSArray *interiorPolygons;

/**Create a polygon using a collection of coordinates
 * @param coords c array of CLLocationcCoordinate2D coordinates
 * @param count number of coordinates being passed in array
 * @return new polygon object
 */
+ (MQPolygon *)polygonWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count;

/**Create a polygon using a collection of coordinates w/interior polygons
 * @param coords c array of CLLocationcCoordinate2D coordinates
 * @param count number of coordinates being passed in array
 * @param interiorPolygons NSArray of polygon objects
 * @return new polygon object
 */
+ (MQPolygon *)polygonWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count interiorPolygons:(NSArray *)interiorPolygons;

/**Create a polygon using a collection of map points
 * @param points c array of CLLocationcCoordinate2D coordinates
 * @param count number of coordinates being passed in array
 * @return polygon object
 */
+ (MQPolygon *)polygonWithPoints:(MQMapPoint *)points count:(NSUInteger)count;

/**Create a polygon using a collection of map points w/interior polygons
 * @param points c array of CLLocationcCoordinate2D coordinates
 * @param count number of coordinates being passed in array
 * @param interiorPolygons NSArray of polygon objects
 * @return polygon object
 */
+ (MQPolygon *)polygonWithPoints:(MQMapPoint *)points count:(NSUInteger)count interiorPolygons:(NSArray *)interiorPolygons;


@end
