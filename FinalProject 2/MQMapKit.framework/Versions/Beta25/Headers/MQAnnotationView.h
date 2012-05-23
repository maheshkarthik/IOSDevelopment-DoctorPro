//
//  MQAnnotationView.h
//  mq_ios_sdk
//
//  Created by Ty Beltramo on 7/5/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQAnnotation.h"
#import "MQCalloutView.h"

@protocol MQAnnotationViewDelegate;

///Drag states to signal changes in the drag lifecycle
typedef enum MQAnnotationViewDragState {
    MQAnnotationViewDragStateNone = 0,
    MQAnnotationViewDragStateStarting,
    MQAnnotationViewDragStateDragging,
    MQAnnotationViewDragStateCanceling,
    MQAnnotationViewDragStateEnding
} MQAnnotationViewDragState;

/**
 * The basic view for an annotation. Override the image
 */
@interface MQAnnotationView : UIView {
    MQCalloutView *calloutView;
    id<MQAnnotationViewDelegate>delegate;

}

///The MQAnnotation associated with this annotation view. The setter for this property should not be called directly. When the MapView askes the MQMapViewDelegate for a view, the MapView will create the assocation and manage the association between the MQAnnotation and the MQAnnotationView.
@property (nonatomic, retain) id <MQAnnotation> annotation;

///By default, the MQCalloutView is rendered directly above the center of the annotation view.  Defaults to CGPointZero. Positive values move the callout view down and to the right. Negative values move the callout view up and to the left.
@property (nonatomic) CGPoint calloutOffset;

///Will return NO if the property calloutView is null or the annotation is disabled or the MQAnnotation title is empty. 
@property (nonatomic) BOOL canShowCallout;

/// Defaults to CGPointZero. Positive values move the annotation view down and to the right. Negative values move the annotation view up and to the left.
@property (nonatomic) CGPoint centerOffset;

///Indicates whether the annotation is draggable or not. 
@property (nonatomic, getter=isDraggable) BOOL draggable;

///Indicates at what state a drag operation is in, if any. Do not set this property directly.
@property (nonatomic) MQAnnotationViewDragState dragState;

/**If enabled, an annotation will respond to touch events by alternately showing and hiding a callout view that contains title and subtitle information from the
* associated annotation, as well as any custom accessory views.
*/
@property (nonatomic, getter=isEnabled) BOOL enabled;

//TODO: Does this do anything by default?
@property (nonatomic, getter=isHighlighted) BOOL highlighted;

///The image used to render the annotation on the map. This may be set to customize the appearance of the annotation.
@property (nonatomic, retain) UIImage *image;

/** A view of no more than 32 pixels in height that will be rendered in the left side of the callout bubble. If this view is a UIControl, taps will forwarded to the MQMapViewDelegate. 
*/
@property (nonatomic, retain) UIView *leftCalloutAccessoryView;

/** A view of no more than 32 pixels in height that will be rendered in the right side of the callout bubble. If this view is a UIControl, taps will forwarded to the MQMapViewDelegate. 
 */
@property (nonatomic, retain) UIView *rightCalloutAccessoryView;

/**
 * MQAnnotationView objects are designed to be reused during map rendering operations. Cannot be nil. Annotation views will be cached according to their identifiers and dequeued upon request.
 */
@property (nonatomic, readonly) NSString *reuseIdentifier;

///Mark the annotation as selected in its internal state. May or may not have any visual impact how the annotation view is rendered
@property (nonatomic, getter=isSelected) BOOL selected;

/**
 A custom annotation view class can override the calloutView to achieve custom callout effects
 */
@property (nonatomic, retain) MQCalloutView *calloutView;

//TODO - make this private/hidden
@property (nonatomic, assign) id<MQAnnotationViewDelegate>delegate;

/**The primary initializer. Create MQAnnotations with this method only, or be sure to call [super] from within custom subclasses.
* @param annotation The annotation that is associated with the view. Cannot be nil, but may be changed. If changed, remove and re-add the annotation to the map.
* @param reuseIdentifier The string used to cache unused views. Used in the dequeue method of the MQMapView.
*/
 - (id)initWithAnnotation:(id <MQAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

/// When an annotation view object is dequeued for reuse, the MQMapView object will call this method prior to returning it. Does nothing by default.  
- (void)prepareForReuse;

/** Informs the annotation view that its drag state has changed and whether any response (such as lifting the pin from the map) should be animated.
 * If dragging functionality is implemented, the setCoordinate method must also be implemented.
 * @param newDragState The drag state that has been transitioned to.
 * @param animated Wether to animate the transition of the drag state.
 */
- (void)setDragState:(MQAnnotationViewDragState)newDragState animated:(BOOL)animated;

/** Marks the annotation as selected within its internal state.
 * @warning The callout will not display simply by calling this method. Call the method MQMapView selectAnnotation:animated instead.
 * @param selected - Mark the annotation as being in the selected state. The meaning of this is determined by the annotation view. 
 * @param animated - If changes to the selected state imply visual changes, it is up to the annotation view implementation to render those as animations or not.
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

/**The callout has to be a subview of the map in order to process accessoryView events
* since it cannot fit inside the frame of the annotation
*/
-(UIView*)viewForCallout;

-(BOOL)isCalloutViewReady;

@end

//TODO - make this private/hidden
@protocol MQAnnotationViewDelegate <NSObject>

-(void)annotationView:(MQAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
-(void)annotationViewTapped:(MQAnnotationView *)view;

@end
