//
//  MQOverlayPathView.h
//  mq_ios_sdk
//
//  Created by Erik Scrafford on 8/8/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQOverlayView.h"

/** The MQOverlayPathView is the base class for all views that use paths as their means of drawing their overlays
 *
 */
@interface MQOverlayPathView : MQOverlayView {
    UIColor*    m_fillColor;
    CGLineCap   m_lineCap;
    NSArray*    m_lineDashPattern;
    CGFloat     m_lineDashPhase;
    CGLineJoin  m_lineJoin;
    CGFloat     m_lineWidth;
    CGFloat     m_miterLimit;
    CGPathRef   m_path;
    UIColor*    m_strokeColor;
}

///Fill color to be used in filling a path. If fillColor is not set, the path will not be filled.
@property (retain) UIColor *fillColor;

///Line cap style to be used when stroking a path
@property CGLineCap lineCap;

/**An array of one or more NSNumbers representing the lengths and gaps of segments in the
 * line to be stroked. The values alternate, starting with line length, followed by gap length.
 */
@property (copy) NSArray *lineDashPattern;

///Line dash phase used while stroking a path
@property CGFloat lineDashPhase;

///Line join style used while stroking a path
@property CGLineJoin lineJoin;

///Line width used while stroking a path
@property CGFloat lineWidth;

///Miter limit used while stroking a path
@property CGFloat miterLimit;

///The path to be stroked and/or filled. If this is nil, createPath will be called to set it.
@property CGPathRef path;

///Stroke color to be used while stroking a path. If strokeColor is not set, the path will not be stroked.
@property (retain) UIColor *strokeColor;

/**Apply all the properties related to filling to the given context
 * @param context The context to be drawn into
 * @param zoomScale The scale at which drawing needs to occur
*/
- (void)applyFillPropertiesToContext:(CGContextRef)context atZoomScale:(MQZoomScale)zoomScale;

/**Apply all the properties related to stroking to the given context
 * @param context The context to be drawn into
 * @param zoomScale The scale at which drawing needs to occur
 */
- (void)applyStrokePropertiesToContext:(CGContextRef)context atZoomScale:(MQZoomScale)zoomScale;

/**Create a path to be stroked and/or filled, and set the path property when done.
 */
- (void)createPath;

/**fill a path
 * @param path The path to be filled
 * @param context The context to be drawn into
 */
- (void)fillPath:(CGPathRef)path inContext:(CGContextRef)context;

///Invalidate path
- (void)invalidatePath;

/**stroke a path
 * @param path The path to be filled
 * @param context The context to be drawn into
 */
- (void)strokePath:(CGPathRef)path inContext:(CGContextRef)context;



@end
