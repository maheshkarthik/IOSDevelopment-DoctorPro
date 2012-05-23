//
//  MQOverlayView.h
//  mq_ios_sdk
//
//  Created by Erik Scrafford on 8/5/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQGeometry.h"
#import "MQOverlay.h"

/** The MQOverlayView is the base class for all overlay view implementations. 
 *
 */
@interface MQOverlayView : UIView {
    id <MQOverlay> m_overlay;
}

///The overlay attached to this overlay view
@property (nonatomic, readonly) id <MQOverlay> overlay;

/**Ask this overlay view if it can draw the given mapRect
 * @param mapRect The map rect that serves as the projected boundary around some annotations
 * @param zoomScale The zoomScale to be drawn at
 * @return a BOOL whether the mapRect can be drawn
 */
- (BOOL)canDrawMapRect:(MQMapRect)mapRect zoomScale:(MQZoomScale)zoomScale;


/**Draw into the given mapRect at zoomScale using the passed context
 * @param mapRect The map rect that serves as the projected boundary around some annotations
 * @param zoomScale The zoomScale to be drawn at
 * @param context The context to draw into
 * @return a BOOL whether the mapRect can be drawn
 */
- (void)drawMapRect:(MQMapRect)mapRect zoomScale:(MQZoomScale)zoomScale inContext:(CGContextRef)context;

/**Initialization method for MQOverlayView
 * @param overlay An MQOverlay that this view will be representing on screen
 * @return a new MQOverlay object
 */
- (id)initWithOverlay:(id <MQOverlay>)overlay;

/**Translate a screen point into a map point
 * @param point A screen point to be translated
 * @return a point in map points
 */
- (MQMapPoint)mapPointForPoint:(CGPoint)point;

/**Translate a screen region into a map region
 * @param rect A screen region to be translated
 * @return a region in map points
 */
- (MQMapRect)mapRectForRect:(CGRect)rect;

/**Translate a map point into a screen point
 * @param mapPoint A map point to be translated
 * @return a screen point
 */
- (CGPoint)pointForMapPoint:(MQMapPoint)mapPoint;

/**Translate a map region into a screen region
 * @param mapRect A map region to be translated
 * @return a screen region
 */
- (CGRect)rectForMapRect:(MQMapRect)mapRect;

/**Mark the overlay as needing to be redrawn
 * @param mapRect region that needs to be redrawn
 */
- (void)setNeedsDisplayInMapRect:(MQMapRect)mapRect;

/**Mark the overlay as needing to be redrawn
 * @param mapRect region that needs to be redrawn
 * @param zoomScale zoom scale at which the region needs to be redrawn
 */
- (void)setNeedsDisplayInMapRect:(MQMapRect)mapRect zoomScale:(MQZoomScale)zoomScale;


/**Get the current zoom scale
 * @return the current scale
 */
-(double)scale;

-(float)zoom;

-(float)ratio;

@end
