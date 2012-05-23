//
//  MQGeometry.h
//  mq_ios_sdk
//
//  Created by Ty Beltramo on 7/20/11.
//  Copyright 2011 MapQuest. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>
#import "MQFoundation.h"

/** @file MQGeometry.h
 *
 */

@interface MQGeometry : NSObject 
@end

/** A distance in degrees, latitudinal and longitudinal
 * @param latitudeDelta - the distance in degrees latitude
 * @param longitudeDelta = the distance in degrees longigude
 */
typedef struct {
    CLLocationDegrees latitudeDelta;
    CLLocationDegrees longitudeDelta;
} MQCoordinateSpan;

/** A region in the lat/lon coordinate system
 * @param center The center coordinate of the span (not origin)
 * @param span The longitudinal and latitudinal dimensions of the region
 */
typedef struct {
	CLLocationCoordinate2D center;
	MQCoordinateSpan span;
} MQCoordinateRegion;


/** A convenience method for constructing MQCoordinateSpans
 * @param latitudeDelta The latitudinal dimension of the span
 * @param longitudeDelta The longitudinal dimension of the span
 */
static MQCoordinateSpan MQCoordinateSpanMake(CLLocationDegrees latitudeDelta, CLLocationDegrees longitudeDelta)
{
    MQCoordinateSpan span;
    span.latitudeDelta = latitudeDelta;
    span.longitudeDelta = longitudeDelta;
    return span;
}

/** A convenience method for construction MQCoordinateRegions
 * @param centerCoordinate The center of the region in the lat/lon coordinate system
 * @param span The dimensions of the region in degrees
 */
static MQCoordinateRegion MQCoordinateRegionMake(CLLocationCoordinate2D centerCoordinate, MQCoordinateSpan span)
{
	MQCoordinateRegion region;
	region.center = centerCoordinate;
    region.span = span;
	return region;
}

/** A convenience method for constructing MQCoordinateRegions using distances to specify dimensions instead of degrees
 * @param centerCoordinate The center of the region in the lat/lon coordinate system
 * @param latitudinalMeters The latitudinal dimension expressed in meters
 * @param longitudinalMeters The longitudinal dimension expressed in meters 
 */
MQ_EXTERN MQCoordinateRegion MQCoordinateRegionMakeWithDistance(CLLocationCoordinate2D centerCoordinate, CLLocationDistance latitudinalMeters, CLLocationDistance longitudinalMeters);

/** A convenience method for constructing MQCoordinateRegions using two coordinates to specify dimensions instead of degrees
 * @param upperLeft The upper left coordinate of the region
 * @param lowerRight The lower right coordinate of the region
 */
MQ_EXTERN MQCoordinateRegion MQCoordinateRegionMakeWithCoordinates(CLLocationCoordinate2D upperLeft, CLLocationCoordinate2D lowerRight);

/** A point on a map in a projected coordinate system. The point can be converted to a lat/lon and back. 
 * @param x the projected x-axis value, cooresponding to the longitude in a real-world coordinate system
 * @param y the projected y-axis value, cooresponding to the latitude in a real-world coordinate system
 */
typedef struct {
    double x;
    double y;
} MQMapPoint;

/** The dimensions of the map in MQMapPoints (projected)
 * @param width The width of the map at some scale
 * @param height The height of the map at some scale
 */
typedef struct {
    double width;
    double height;
} MQMapSize;

/** A rectangular region of a map measured in MQMapPoints (projected)
 * @param origin The upper left most point of the region
 * @param size The dimension of the map in MQMapPoints
 */
typedef struct {
    MQMapPoint origin;
    MQMapSize size;
} MQMapRect;

/** MQZoomScale provides a conversion factor between MQMapPoints and screen points.
 * When MQZoomScale = 1, 1 screen point = 1 MKMapPoint.  When MQZoomScale is
 * 0.5, 1 screen point = 2 MKMapPoints.
 */
typedef CGFloat MQZoomScale;

///An invalid or unknown MQMapRect
MQ_EXTERN const MQMapRect MQMapRectNull;

///The size of the projected world map without scale (i.e. at maximum zoom)
MQ_EXTERN const MQMapSize MQMapSizeWorld;

///The rect representing the world map without scale (i.e. at maximum zoom)
MQ_EXTERN const MQMapRect MQMapRectWorld;

/** Converts a coordinate (in the lat/lon coordinate system) into a MQMapPoint without scale (projected)
 * @param coordinate The lat/lon to be converted into a MQMapPoint using a map projection
 */
MQ_EXTERN MQMapPoint MQMapPointForCoordinate(CLLocationCoordinate2D coordinate);

/** Converts an MQMapPoint (projected) into a lat/lon representing a real-world location
 * @param mapPoint The scale-free MQMapPoint from a projected map to be converted
 */
MQ_EXTERN CLLocationCoordinate2D MQCoordinateForMapPoint(MQMapPoint mapPoint);

/**Calculates the longintudinal distance expressed by one MQMapPoint (at max zoom), taking into account the spherical shape of the earth
 * @param latitude The degrees of latitude of the MQMapPoint
 */
MQ_EXTERN CLLocationDistance MQMetersPerMapPointAtLatitude(CLLocationDegrees latitude);

/**Calculates the longintudinal distance expressed by one MQMapPoint at a certain zoom level, taking into account the spherical shape of the earth
 * @param lat The degrees of latitude of the MQMapPoint
 * @param zoomLevel The zoom level of the projected map
 */
MQ_EXTERN CLLocationDistance MQMetersPerMapPointAtLatituteAndZoom(CLLocationDegrees lat, int zoomLevel);

/** Calculates how many MQMapPoints (at max zoom) are contained in a meter at a specific latitude
 * @param latitude The degrees of latitude of the MQMapPoint
 */
MQ_EXTERN double MQMapPointsPerMeterAtLatitude(CLLocationDegrees latitude);

/** Calculates the real-world "as the crow flies" distance in meters between to MQMapPoints on a projected map at max zoom
 * Take into account the spherical shape of the earth and the projection of the map
 * @param a The first map point
 * @param b The second map point
 * @warning This calculation converts the map points to lat/lon coordinates prior to calculating the distance, so distances that span the 180th meridian are supported.
 */
MQ_EXTERN CLLocationDistance MQMetersBetweenMapPoints(MQMapPoint a, MQMapPoint b);

/** A convenience method for constructing projected MQMapPoints
 * @param x The x value
 * @param y The y value
 */
NS_INLINE MQMapPoint MQMapPointMake(double x, double y) {
    return (MQMapPoint){x, y};
}

/** A convenience method for constructing an MQMapSize
 * @param width The width of the map in MQMapPoints
 * @param height The height of the map in MQMapPoints
 */
NS_INLINE MQMapSize MQMapSizeMake(double width, double height) {
    return (MQMapSize){width, height};
}

/**A convenience method for constructing MQMapRects
 * @param x The x value of the rect's origin
 * @param y the y value of the rect's origin
 * @param width The width in MQMapPoints
 * @param height The height in MQMapPoints
 */
NS_INLINE MQMapRect MQMapRectMake(double x, double y, double width, double height) {
    return (MQMapRect){ MQMapPointMake(x, y), MQMapSizeMake(width, height) };
}

/**A convenience method for obtaining the miminum x value of a map rect
 * @param The rect for which the min x is desired
 * @warning If the width of the rect is negative, the MinX will be less than the origin, MQMapRects are not normalized
 */
NS_INLINE double MQMapRectGetMinX(MQMapRect rect) {
    if (rect.size.width < 0)
        return rect.origin.x + rect.size.width;
    else
        return rect.origin.x;
}

/**A convenience method for obtaining the miminum y value of a map rect
 * @param The rect for which the min y is desired
 * @warning If the height of the rect is negative, the MinY will be less than the origin, MQMapRects are not normalized
 */
NS_INLINE double MQMapRectGetMinY(MQMapRect rect) {
    if (rect.size.height < 0)
        return rect.origin.y + rect.size.height;
    else
        return rect.origin.y;
}

/**A convenience method to get the middle x value of a rect
 * @param rect The rect for which the MidX value is desired
 */
NS_INLINE double MQMapRectGetMidX(MQMapRect rect) {
    return rect.origin.x + rect.size.width / 2.0;
}

/**A convenience method to get the middle y value of a rect
 * @param rect The rect for which the MidY value is desired
 */
NS_INLINE double MQMapRectGetMidY(MQMapRect rect) {
    return rect.origin.y + rect.size.height / 2.0;
}

/**A convenience method for obtaining the maximum x value of a map rect
 * @param The rect for which the max x is desired
 * @warning If the width of the rect is negative, the MaxX will be the origin, MQMapRects are not normalized
 */
NS_INLINE double MQMapRectGetMaxX(MQMapRect rect) {
    if (rect.size.width < 0)
        return rect.origin.x;
    else
        return rect.origin.x + rect.size.width;
}

/**A convenience method for obtaining the maximum xy value of a map rect
 * @param The rect for which the max y is desired
 * @warning If the height of the rect is negative, the MaxY will be the origin, MQMapRects are not normalized
 */
NS_INLINE double MQMapRectGetMaxY(MQMapRect rect) {
    if (rect.size.height < 0)
        return rect.origin.y;
    else
        return rect.origin.y + rect.size.height;
}

/**A convenience method to get the width (non-normalized)
 * @param rect The rect with the width
 */
NS_INLINE double MQMapRectGetWidth(MQMapRect rect) {
    return rect.size.width;
}

/**A convenience method to the the height of the rect (non-normalized)
 * @param rect the rect with the height
 */
NS_INLINE double MQMapRectGetHeight(MQMapRect rect) {
    return rect.size.height;
}

/** Return whether two map points share the same x,y values
 * @param point1 An MQMapPoint
 * @param point2 Another MQMapPoint
 */
NS_INLINE BOOL MQMapPointEqualToPoint(MQMapPoint point1, MQMapPoint point2) {
    return point1.x == point2.x && point1.y == point2.y;
}

/** Return whether two MQMapSizes have the same dimensions
 * @param size1 A MQMapSize
 * @param size2 Another MQMapSize
 */
NS_INLINE BOOL MQMapSizeEqualToSize(MQMapSize size1, MQMapSize size2) {
    return size1.width == size2.width && size1.height == size2.height;
}

/** Return whether to MQMapRects have the same origin and dimensions
 * @param rect1 A MQMapRect
 * @param rect2 Another MQMapRect
 */
NS_INLINE BOOL MQMapRectEqualToRect(MQMapRect rect1, MQMapRect rect2) {
    return 
    MQMapPointEqualToPoint(rect1.origin, rect2.origin) &&
    MQMapSizeEqualToSize(rect1.size, rect2.size);
}

/** Returns whether a MQMapRect has uknown or invalid properties
 * @param rect The MQMapRect to test
 */
NS_INLINE BOOL MQMapRectIsNull(MQMapRect rect) {
    return isinf(rect.origin.x) || isinf(rect.origin.y);
}

/** Returns true if the MQMapRect has zero width and height, or if it is NULL
 * @param rect A MQMapRect to test
 */
NS_INLINE BOOL MQMapRectIsEmpty(MQMapRect rect) {
    return MQMapRectIsNull(rect) || (rect.size.width == 0.0 || rect.size.height == 0.0);
}

/**Generate a description of an MQMapPoint
 * @param point The point to describe
 */
NS_INLINE NSString *MQStringFromMapPoint(MQMapPoint point) {
    return [NSString stringWithFormat:@"{%.1f, %.1f}", point.x, point.y];
}

/**Generate a description for an MQMapSize
 * @param size The size to describe
 */
NS_INLINE NSString *MQStringFromMapSize(MQMapSize size) {
    return [NSString stringWithFormat:@"{%.1f, %.1f}", size.width, size.height];
}

/**Generate a description for an MQMapRect
 * @param rect The rect to describe
 */
NS_INLINE NSString *MQStringFromMapRect(MQMapRect rect) {
    return [NSString stringWithFormat:@"{%@, %@}", MQStringFromMapPoint(rect.origin), MQStringFromMapSize(rect.size)];
}

/** Returns the union in the form of an MBR of the two rects. 
 * @warning Will return MQMapRectNull if either parameter is MQMapRectNull
 * @param rect1 an MQMapRect
 * @param rect2 an MQMapRect
 */
MQ_EXTERN MQMapRect MQMapRectUnion(MQMapRect rect1, MQMapRect rect2);

/** Returns the intersection of the two rects. 
 * @warning Will return MQMapRectNull if either parameter is MQMapRectNull
 * @param rect1 an MQMapRect
 * @param rect2 an MQMapRect
 */
MQ_EXTERN MQMapRect MQMapRectIntersection(MQMapRect rect1, MQMapRect rect2);

/**Returns a rect with the same center, but inset dimensions
 * Positive values make the inset smaller, negative values make the inset larger
 * @param rect The rect to use as the base from which to create the new rect
 * @param dx The difference in the width
 * @param dy The difference in the height
 */
MQ_EXTERN MQMapRect MQMapRectInset(MQMapRect rect, double dx, double dy);

/**Returns a rect with an origin offect vertically and horizontally
 * Positive values move the origin down and to the right. Negative values up and to the left.
 * @param rect The rect to use as the base from which to create the offset rect
 * @param dx The distance to shift the origin on the x axis
 * @param dy The distance to shift the origin on the y axis
 */
MQ_EXTERN MQMapRect MQMapRectOffset(MQMapRect rect, double dx, double dy);

/** Removes a slice from the rect
 * @param rect The rect to divide - This may be rotated.
 * @param slice A pointer to a MQMapRect that will contain the sliced (removed) portion of the rect
 * @param remainder A pointer to a MQMapRect that will contain what's left of the original rect after slicing
 * @param amount The amount of rect to slice along the edge. If this is zero or negative, no slicing will occur
 * @param edge A CGRectEdge that represents the dividing line through the rect
 * @warning The edge must be parallel to two of the sides of the rect
 */
MQ_EXTERN void MQMapRectDivide(MQMapRect rect, MQMapRect *slice, MQMapRect *remainder, double amount, CGRectEdge edge);

/**Return whether a rect contains a specific point (projected)
 * @param rect The bounding rect
 * @param point The MQMapPoint to test
 */
MQ_EXTERN BOOL MQMapRectContainsPoint(MQMapRect rect, MQMapPoint point);

/** Return whether all points of one rect lie in the bounds of another
 * @param rect1 The bounding rect
 * @param rect2 The rect being tested to see if it lies inside rect1
 */
MQ_EXTERN BOOL MQMapRectContainsRect(MQMapRect rect1, MQMapRect rect2);

/** Return whether any points of one rect lie in the bounds of another
 * @param rect1 The bounding rect
 * @param rect2 The rect being tested to see if any of its points lies inside rect1
 */
MQ_EXTERN BOOL MQMapRectIntersectsRect(MQMapRect rect1, MQMapRect rect2);

/**Construct an MQCoordinateRegion (un-projected) from an MQMapRect (projected) 
 * @param rect The unscaled (max zoom level) MQMapRect to convert into a coordinate region (in the lat/lon coordinate system)
 */
MQ_EXTERN MQCoordinateRegion MQCoordinateRegionForMapRect(MQMapRect rect);

/**Return true if the rect extends beyond the edge of the world map
 * @param rect The rect to test
 */
MQ_EXTERN BOOL MQMapRectSpans180thMeridian(MQMapRect rect);

/**If a rect spans the edge of the world map (projected), returns the rect representing that part of the rect that extends beyond the map edge, wrapped around to the other edge of the map.
 * @param rect The rect that spans the 180th meridian
 */
MQ_EXTERN MQMapRect MQMapRectRemainder(MQMapRect rect);

/**Convenience method to convert degrees to Rads
 * @param deg The degrees to convert
 */
MQ_EXTERN double degreesToRads(double deg);

/** Measure the longitudinal meters spanning a degree at a particular latitude
 * @param lat The degrees latitude
 */
MQ_EXTERN CLLocationDistance metersPerDegreeAtLat(double lat);

/**Mesure the latitudinal meters spanning a degree at a particular lon
 * This value never changes, since the geographic distance between degrees latitude is constant
 * @param lon The degrees of longitude
 */
MQ_EXTERN CLLocationDistance metersPerDegreeAtLon(double lon);

/**Measures longitudinal degrees spanning a meter at a specific lat
 * @param lat The degrees of latitude
 */
MQ_EXTERN CLLocationDegrees degreesPerMeterAtLat(double lat);

/**Measures teh latitudinal degrees spanning a meter at a specific lon
 * This value never changes, since the geographic distance between degrees latitude is constant
 * @param lon The degrees of longitude
 */
MQ_EXTERN CLLocationDegrees degreesPerMeterAtLon(double lon);


NS_INLINE MQMapPoint MQMapPointCenterOfMapRect(MQMapRect rect) {
    //Get a new center point
   return MQMapPointMake((((MQMapRectGetMaxX(rect) - rect.origin.x) / 2.0) + rect.origin.x) , (((MQMapRectGetMaxY(rect) - rect.origin.y)/ 2.0) + rect.origin.y) );
}

/** Constructs an MQMapRect (projected) from an MQCoordinateRegion (un-projected)
 * @param region coordinate region (lat/lon and span in degrees)
 */
MQ_EXTERN MQMapRect MQMapRectForMQCoordinateRegion(MQCoordinateRegion region);

MQ_EXTERN MQMapRect MQMBR(MQMapPoint *points, NSUInteger count);

MQ_EXTERN  CGFloat distanceBetweenPoints (CGPoint first, CGPoint second);
