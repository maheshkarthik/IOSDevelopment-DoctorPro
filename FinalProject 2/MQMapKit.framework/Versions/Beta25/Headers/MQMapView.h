//
//  MQMapView.h
//  mq_ios_sdk
//
//  Created by Erik Scrafford, Ty Beltramo.
//  Copyright 2011 AOL/MapQuest. All rights reserved.
//

#import "MQMapKitDropIn.h"
#import <Foundation/Foundation.h>
#import "MQTypes.h"
#import "QuartzCore/QuartzCore.h"
#import "UIKit/UIKit.h"
#import "MQAnnotation.h"
#import "MQAnnotationView.h"
#import "MQUserLocation.h"
#import "MQGeometry.h"
#import "MQOverlay.h"
#import "MQOverlayView.h"

@protocol MQMapViewDelegate;

/**
 * The MapView: Loads map tiles and provides zooming, panning, overlays, and point annotation handling.
 */
@interface MQMapView : UIView
{
     
    BOOL showsUserLocation;
    BOOL showsHeading;
    
    MQUserLocation *m_userLocation;
    CLHeading *m_currentHeading;
    
}

@property(nonatomic) MQMapType mapType;


/**Returns true if map zooming (via multitouch events) is enabled. 
 * @warning The zoom level can be programatically set wither this property is true or false
 */
@property(nonatomic, getter=isZoomEnabled) BOOL zoomEnabled;

/**Returns true if panning (vai touch events) is enabled.
 * @warning The display area can be scrolled programatically wither this property is true or false
 */
@property(nonatomic, getter=isScrollEnabled) BOOL scrollEnabled;

/**The center lat/lon of the displayed map.
 * Setting this property changes the viewed portion of the map immediately. To change the center with animation, use setCenterCoordinate:animated instead.
 */
@property CLLocationCoordinate2D centerCoordinate;

/**The MQCoordinateRegion currently displayed in the map view.
 * Setting this property causes the viewed region to change immediately. To animate the change, use setRegion:animated instead;
 */
@property (nonatomic) MQCoordinateRegion region;

///The visible rectangle where annotation views are currently being displayed. (read-only)
@property(nonatomic, readonly) CGRect annotationVisibleRect;

/**The portion of the map that is visible to the user. 
 * This is represented as an MQMapRect roughly conformed to screen dimensions
 * @warning Setting this property will result in an approximation of the passed-in value, accounting for best-fit scaling
 */
@property(nonatomic) MQMapRect visibleMapRect;

/**Determines whether the map is allowed to display user location.
 * Setting this property to YES causes the map to begin tracking the user's location using CLLocationManager
 */
@property (nonatomic) BOOL showsUserLocation;

/**Determines whether the map is allowed to display heading.
 * Setting this property to YES causes the map to begin tracking heading and rotating accordingly
 */
@property (nonatomic) BOOL showsHeading;

///The last recorded user's location
@property( readonly) MQUserLocation *userLocation;

///Indicates whether the user location is within the visible portion of the mapview
@property(readonly, getter=isUserLocationVisible) BOOL userLocationVisible;

///The collection of annotations currently associated with the map. This includes those both inside and outside the visible rect of the map.
@property (nonatomic, readonly) NSArray *annotations;

/** Gets an array of currently selected annotations
 * @warning *NOTE:* setting this selects the first entry in the array ONLY
 */
@property (nonatomic, copy) NSArray *selectedAnnotations;

///The collection of overlays currently associated with the map. This includes those both inside and outside the visible rect of the map.
@property (nonatomic, readonly) NSArray *overlays;

///The delegate of the mapview conforming to the MQMapViewDelegate protocol
@property (nonatomic, assign) IBOutlet id <MQMapViewDelegate> delegate;


/**Sets the visible region of the map view, allowing the change to be animated.
 * @param region The region to display in the visible map
 * @param animate Wether to animate the region change or to made the change immediately
 * @warning The actual region displayed by the view is an approximation of the passed in region. To get the actual region that will be displayed, use regionThatFits:
 */
-(void)setRegion:(MQCoordinateRegion)region animated:(BOOL)animate;

/**Sets the visible map rect of the map view, allowing the change to be animated.
 * @param rect The map rect to display in the visible map
 * @param animate Wether to animate the rect change or to made the change immediately
 * @warning The actual rect displayed by the view is an approximation of the passed in rect. To get the actual rect that will be displayed, use rectThatFits:
 */
-(void)setVisibleMapRect:(MQMapRect)rect animated:(BOOL)animate;

/**Adjusts the displayed map area to be centered on the given coordinate at the current zoom level
 * @param coordinate The coordinate to use as the center of the map
 * @param animated Whether the change will be animated
 */
-(void)setCenterCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated;

/**Sets the visible map rect of the map view, allowing the change to be animated, accounding for padding in screen points.
 * @param mapRect The map rect to display in the visible map
 * @param insets UIEdgeInsets that define the area in screen points around the rect to inset
 * @param animate Wether to animate the rect change or to made the change immediately
 * @warning The actual rect displayed by the view is an approximation of the passed in rect. To get the actual rect that will be displayed, use rectThatFits:
 */
-(void)setVisibleMapRect:(MQMapRect)mapRect edgePadding:(UIEdgeInsets)insets animated:(BOOL)animate;

/**Returns annotations whose coordinates fit within the specified map rect
 * @param mapRect The map rect that serves as the projected boundary around some annotations
 * @return an immutable set of objects conforming to the MQAnnotation protocol
 */
-(NSSet *)annotationsInMapRect:(MQMapRect)mapRect;

/**Converts a coordinate to a screen point in the specified view. The view must be in the same view heirarchy as the map view.
 * @param coordinate The coordinate to convert
 * @param view The view in which you wish to determine the position of the coordinate
 * @return a CGPoint in the coordinate system of the specified view
 */
- (CGPoint)convertCoordinate:(CLLocationCoordinate2D)coordinate toPointToView:(UIView *)view;

/**Converts a CGPoint in the coordinate system of the specified view to a lat/lon. The view must be in the same view heirarchy as the map view.
 * @param point The point to convert
 * @param view The view in which you wish to determine the lat lon of the point
 * @return a CLLocationCoordinate2D for the point in the specified view
 */
- (CLLocationCoordinate2D)convertPoint:(CGPoint)point toCoordinateFromView:(UIView *)view;

/**Converts a rect in the coordinate system of the specified view to an MQCoordinateRegion. The view must be in the same view heirarchy as the map view.
 * @param rect The rect to convert
 * @param view The view that contains the rect to convert
 * @return an MQCoordinateRegion for the rect in the specified view
 */
- (MQCoordinateRegion)convertRect:(CGRect)rect toRegionFromView:(UIView *)view;

/**Converts an MQCoordinateRegion to a CGRect in the coordinate system of the specified view. The view must be in the same view heirarchy as the map view.
 * @param region The MQCoordinateRegion to convert
 * @param view The view that contains the rect to convert
 * @return a CGRect for the region in the specified view
 */
- (CGRect)convertRegion:(MQCoordinateRegion)region toRectToView:(UIView *)view;

/**Returns a region with its span adjusted to fit into the display window of the map at the current zoom level
 * The center is the same as that of the region to adjust
 * @param region The region that you wish to adjust
 * @return An region with the span adjusted to fit the current displayed area
 */
- (MQCoordinateRegion)regionThatFits:(MQCoordinateRegion)region;

/**Returns a map rect adjusted to fit into the current display window of the map using the current zoom level, with edge padding applied
 * The center remains the same as the rect passed in
 * @param mapRect The map rect to adjust
 * @param insets The insets in screen points to pad around the rect
 * @return An map rect that fits into the display window of the map
 */
- (MQMapRect)mapRectThatFits:(MQMapRect)mapRect edgePadding:(UIEdgeInsets)insets;

/**Returns an adjusted map rect that fits into the current map display area at the current zoom level
 * @param mapRect The map rect to adjust
 * @return A mapRect that fits into the window of the map
 */
- (MQMapRect)mapRectThatFits:(MQMapRect)mapRect;


/** Add an annotation to the map. The annotation must conform to the MQAnnotation protocol. The object is retained.
 * @param annotation The annotation to add
 */
- (void)addAnnotation:(id <MQAnnotation>)annotation;

/** Add a collection of annotations to the map.
 * @param annotations The annotations to be added to the map.
 */
- (void)addAnnotations:(NSArray *)annotations;
	
/** Remove an annotation from the map. May be nil. If an annotation view is currently associated with the annotation, it may be cached for reuse.
 *  @param annotation The annotation to be removed.
 */
- (void)removeAnnotation:(id <MQAnnotation>)annotation;

/** Remove a collection of annotations from the map.
 * @param annotations The collection of annotation objects to be removed.
 */
- (void)removeAnnotations:(NSArray *)annotations;	

/** Returns the view, if any, associated with an MQAnnotation. May be nil if the annotation is not in the map's visible rect.
 * @param annotation The annotation associated with the desired view
 * @return The annotation view, if any, associated with the annotation
 */
- (MQAnnotationView *)viewForAnnotation:(id <MQAnnotation>)annotation;
	
/** Returns an cached MQAnnotationView with the specified identifier.
 * It is up to the caller of this method to link the view with an annotation instance.
 * @param identifier The reuse identifier to specify which type of view to dequeue.
 */
- (MQAnnotationView *)dequeueReusableAnnotationViewWithIdentifier:(NSString *)identifier;
	
/** By default, marks the annotation view as selected, requests the calloutView from the annotationView and renders it
 * @param annotation - the annotation to select
 * @param animated - Show the callout view with animation
 */
- (void)selectAnnotation:(id <MQAnnotation>)annotation animated:(BOOL)animated;

/** Delesects the specified annotation. Sets the annotation view's state to not selected. Hides the callout view if currently rendered.
 * @param annotation The annotation to deselect
 * @param animated Whether to animate the hiding of the callout view
 */
- (void)deselectAnnotation:(id <MQAnnotation>)annotation animated:(BOOL)animated;

/** Rotates the map to the indicated heading
 * @param heading The new heading in radians
 * @param animated animate the rotation 
 * @param rotationOffset The offset from center around which to rotate the map in the mapview coord system
 */
-(void)rotateToHeading:(double)heading animated:(BOOL)animated rotationOffset:(CGPoint)rotationPoint;

/** Add an overlay to the map.
 *@param overlay The overlay to be added
 */
- (void)addOverlay:(id < MQOverlay >)overlay;

/** Add a collection of overlays to the map.
 *@param overlays The collection of overlays to be added to the map.
 */
- (void)addOverlays:(NSArray *)overlays;


/** Remove an overlay from the map. May be nil.
 *  @param overlay The overlay to be removed.
 */
- (void)removeOverlay:(id <MQOverlay>)overlay;

/** Remove a collection of overlays from the map.
 * @param overlays The collection of overlay objects to be removed.
 */
- (void)removeOverlays:(NSArray *)overlays;

/** Insert an overlay at a particular point in the drawing order of the overlays to display. Lower indices draw first, so will be below ovelays of higher indices.
 * @param overlay The overlay to insert
 * @param index at which to insert the overlay. This will cause the overlays to be redrawn. If the index is greater than the number of overlays currently displayed, the overlay will be appended to the end of the array of overlays.
 *
 */
- (void)insertOverlay:(id < MQOverlay >)overlay atIndex:(NSUInteger)index;

/** Exchange the drawing order of two overlays.If either of the given indices are invalid, this method will throw an out of bounds exception.
 * @param index1 The index for an overlay to be exchanged
 * @param index2 The index of the other overlay to be exchanged
 */
- (void)exchangeOverlayAtIndex:(NSUInteger)index1 withOverlayAtIndex:(NSUInteger)index2;

/** Inserts an overlay above (visually) another overlay
 * @param overlay The overlay to insert. The overlay may or may not already be added.
 * @param sibling An overlay that has previously been added to the map.
 */
- (void)insertOverlay:(id < MQOverlay >)overlay aboveOverlay:(id < MQOverlay >)sibling;

/** Inserts an overlay below (visually) another overlay
 * @param overlay The overlay to insert. The overlay may or may not already be added.
 * @param sibling An overlay that has previously been added to the map.
 */
- (void)insertOverlay:(id < MQOverlay >)overlay belowOverlay:(id < MQOverlay >)sibling;

/** Retrieve the view, if any, associated with an overlay
 * @param overlay The overlay of the desired view
 */
- (MQOverlayView *)viewForOverlay:(id < MQOverlay >)overlay;

/**Convert a map point to it's corresponding screen location
 * @param mapPoint The mappoint to convert
 * @return A CGPoint in the coordinate system of the view containing the map tiles
 */
-(CGPoint)annotationScreenPointForMapPoint:(MQMapPoint)mapPoint;

/**Convert a map point to it's corresponding screen location
 * @param mapPoint The mappoint to convert
 * @return A CGPoint in the coordinate system of the view containing the map tiles
 */
-(CGPoint)overlayScreenPointForMapPoint:(MQMapPoint)mapPoint;

///The multiplier to convert map point to screen points
-(double)mapScale;

///The scale of zoom of the backing scroll view
-(float)zoomScale;

///The multiplier indicating how many tiles fit into a standard tile size at the current scale
-(float)mapRatio;

-(void)addOverlay:(id<MQOverlay>)overlay withView:(MQOverlayView*)view; 

-(void)setRegionWithModel:(id)routeModel;

@end


/** The MQMapViewDelegate is notified of state changes to the map and its annotations
 *
 */
@protocol MQMapViewDelegate <NSObject>
@optional

/** Returns the view, if any, associated with an MQAnnotation. May be nil if the annotation is not in the map's visible rect.
 * @param mapView The map that is associated with the annotation
 * @param annotation The annotation associated with the desired view
 * @return The annotation view, if any, associated with the annotation
 */
- (MQAnnotationView *)mapView:(MQMapView *)mapView viewForAnnotation:(id <MQAnnotation>)annotation;

/** Callback method informing the delegate that a collection af annotation views have been added to the map (already)
* @param mapView The mapView to which the annotations have been added
* @param views An array of annotation views that have been added.
*/
- (void)mapView:(MQMapView *)mapView didAddAnnotationViews:(NSArray *)views;

/** Inform the delegate that one of the accessory views (being UIControls, in this case) have been tapped
* @warning If more detailed touch event information is required, the creator of the accessory view must add the requisite target/action observers to the control.
* @param mapView The mapview in which the tap occurred
* @param view The annotation view that spawned the callout being tapped
* @param control The accessory view that was tapped.
 */
- (void)mapView:(MQMapView *)mapView annotationView:(MQAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;

/** Inform the delegate that the annotation view was selected
 * @param mapView The mapview containing the annotation
 * @param view The view that was selected
*/
- (void)mapView:(MQMapView *)mapView didSelectAnnotationView:(MQAnnotationView *)view;

/** Inform the delegate that the annotation view was deselected
 * @param mapView The mapview containing the annotation
 * @param view The view that was deselected
 */
- (void)mapView:(MQMapView *)mapView didDeselectAnnotationView:(MQAnnotationView *)view;

/** Inform the delegate that the drag state of an annotation has changed.
 * @param mapView The map in which the annotation exists
 * @param view The annotation view that changed state
 * @param newState The resulting drag state
 * @param oldState The original drag state
 */
- (void)mapView:(MQMapView *)mapView annotationView:(MQAnnotationView *)view didChangeDragState:(MQAnnotationViewDragState)newState 
   fromOldState:(MQAnnotationViewDragState)oldState;

/** Informs the delegate that user location tracking has begun. This method is called when the property showsUserLocation is set to YES;
 * @param mapView The mapView that will display the user location
 */
- (void)mapViewWillStartLocatingUser:(MQMapView *)mapView;

/** Informs the delegate that user location tracking has stopped. This method is called when the property showsUserLocation is set to NO;
 * @param mapView The mapView that will display the user location
 */
- (void)mapViewDidStopLocatingUser:(MQMapView *)mapView;

/** Informs the delegate that the user location has been updated.
 * @param mapView The mapView tracking the user location
 * @param userLocation The last user location received.
 */
- (void)mapView:(MQMapView *)mapView didUpdateUserLocation:(MQUserLocation *)userLocation;

/** Informs the delegate that an attempt to locate the user has failed
 * @param mapView The mapView tracking the user location
 * @param error An error object describing the error that occurred 
 */
- (void)mapView:(MQMapView *)mapView didFailToLocateUserWithError:(NSError *)error;

/** Informs the delegate that the heading has been updated.
 * @param mapView The mapView tracking the heading.
 * @param newHeading The last heading received.
 */
- (void)mapView:(MQMapView *)mapView didUpdateHeading:(CLHeading*)newHeading;

/** Informs the delegate that user location tracking has begun. This method is called when the property showsUserLocation is set to YES;
 * @param mapView The mapView that will display the user location
 */
- (void)mapViewWillStartShowingHeading:(MQMapView *)mapView;

/** Informs the delegate that user location tracking has stopped. This method is called when the property showsUserLocation is set to NO;
 * @param mapView The mapView that will display the user location
 */
- (void)mapViewDidStopShowingHeading:(MQMapView *)mapView;

/**Informs the delegate that the map region is about to change. 
 *@param mapView The map view that is about to change its region
 *@param animated Whether the change will be animated, or take place immediately
 *@warning This method may be called many times during scrolling. Take care to make the implementation very lightweight to avoid performance problems.
 */
- (void)mapView:(MQMapView *)mapView regionWillChangeAnimated:(BOOL)animated;

/**Informs the delegate that the map region has changed. 
 *@param mapView The map view that is about to change its region
 *@param animated Whether the change was animated
 *@warning This method may be called many times during scrolling. Take care to make the implementation very lightweight to avoid performance problems.
 */
- (void)mapView:(MQMapView *)mapView regionDidChangeAnimated:(BOOL)animated;

/** Returns the view, associated with an MQOverlay. If nil is returned, no view will be displayed.
 * @param mapView The map that is associated with the annotation
 * @param overlay The overlay associated with the desired view
 * @return The annotation view associated with the annotation
 */
- (MQOverlayView *)mapView:(MQMapView *)mapView viewForOverlay:(id <MQOverlay>)overlay;

/** Callback method informing the delegate that a collection af overlay views have been added to the map (already)
 * @param mapView The mapView to which the overlays have been added
 * @param views An array of overlay views that have been added.
 */
- (void)mapView:(MQMapView *)mapView didAddOverlayViews:(NSArray *)views;

@end

