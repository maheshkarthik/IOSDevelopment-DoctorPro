//
//  MQRoute.h
//  mq_ios_sdk
//
//  Created by Erik on 10/31/11.
//  Copyright (c) 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQMapView.h"

/**
 Specifies the type of route wanted. Acceptable values are:
 fastest - Quickest drive time route.
 shortest - Shortest driving distance route.
 pedestrian - Walking route; Avoids limited access roads; Ignores turn restrictions.
 multimodal - Combination of walking and (if available) public transit
 bicycle - Will only use roads on which bicycling is appropriate.
 
 Default = 'fastest'
 */
typedef enum {
    MQRouteTypeFastest,
    MQRouteTypeShortest,
    MQRouteTypePedestrian,
    MQRouteTypeMultiModal,
    MQRouteTypeBicycle
} MQRouteType;

/**Upon completion of a route request, the MQRoute object will immediately render the route on the given MQMapView instance.
 * The MQRouteDelegate is informed of request completion and errors.
 * @warning The delegate and methods are optional
 */
@protocol MQRouteDelegate <NSObject>

@optional

/**Called when the route request and parsing are complete.
 * @warning Map rendering is performed on the main thread. This method may be called BEFORE route rendering completes.
 */
-(void)routeLoadFinished;

/**Called when a communication or parsing error occurs. 
 * @param error The error message for the failure.
 */
-(void)routeLoadError:(NSString *)error;

@end

/**A non-reusable route request. Init and configure the MQRoute object, then call one of the getRoute methods to initiate the request
 * @warning Uses OSM routing unless a commerical key is present in the info.plist of the project
 * @warning Once a route is retrieved, the contents of this object are still valid, but reconfiguring and re-use behavior is undefined.
 */
@interface MQRoute : NSObject

///The mapview upon which the route will be rendered
@property (retain)MQMapView *mapView;

///Should the map be repositioned to a region that best fits the route. Default is YES
@property (assign)BOOL bestFitRoute;

///An array of MQManeuver objects sequenced
@property (readonly)NSArray *maneuvers; 

/**The delegate that will be informed that a route is available or that an error occured
 * @warning The delegate is optional
 */
@property (assign)id<MQRouteDelegate> delegate;

///The unparsed XML response for the route requeset
@property (readonly)NSString *rawXML;

///The type of route to request. Default is 'fastest'
@property (assign)MQRouteType routeType;

///The color to use when rendering the route. Must be set prior to the route request being submitted. Defaults to a nice orange.
@property (retain)UIColor *lineColor;

//The width of the line to render. Defaults to 3.5 points.
@property CGFloat lineWidth;

///The fillcolor if one is used. Must be set prior to rendering the route. Defaults to basic black.
@property (retain)UIColor *fillColor;

/** Initiate a route request using starte and end addresses. 
 * @warning The request is fulfilled async.
 * @param startAddress The beginning point of the route
 * @param endAddress The destination.
 */
-(void)getRouteWithStartAddress:(NSString *)startAddress endAddress:(NSString *)endAddress;

/** Initiate a route request using starte and end coordinates. 
 * @warning The request is fulfilled async.
 * @param startCoordinate The beginning point of the route
 * @param endCoordinate The destination.
 */
-(void)getRouteWithStartCoordinate:(CLLocationCoordinate2D)startCoordinate endCoordinate:(CLLocationCoordinate2D)endCoordinate;

@end
