//
//  MQCalloutView.h
//  mq_ios_sdk
//
//  Created by Ty on 7/6/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <UIKit/UIKit.h>

/** The view that is rendered by the MapView when the MQAnnotationView is selected
 * 
 */
@interface MQCalloutView : UIView {
    CGPoint anchorPoint;
    UIView *leftAccessoryView;
    UIView *rightAccessoryView;
    UILabel *calloutTitle;
    UILabel *calloutSubtitle;
}

///The position of the triangle that points to the callout's annotation. Should not be set directly.
@property (nonatomic) CGPoint anchorPoint;

/**The view that is displayed on the left side of the callout bubble. Should be limited to a max of 32pixels in height/width.
 * If the view is a UIControl, tap events will be forwarded to the MQMapViewDelegate. 
 *May be nil.
 */
@property (nonatomic, retain) UIView *leftAccessoryView;

/**The view that is displayed on the right side of the callout bubble. Should be limited to a max of 32pixels in height/width.
 * If the view is a UIControl, tap events will be forwarded to the MQMapViewDelegate. 
 *May be nil.
 */
@property (nonatomic, retain) UIView *rightAccessoryView;

///Title label. Text defaults to the MQAnnotation title. 
@property (nonatomic, retain) UILabel *calloutTitle;

/**Subtitle lable. Text defaults to the MQAnnotation subtitle. 
*@warning An empty title will supress the dispay of a non-empty subtitle.
 */
@property (nonatomic, retain) UILabel *calloutSubtitle;

/**slides the view left or right to maxmimize the amount of the view visible
 * @param aFrame The frame to adjust
 * @param bFrame The frame in which to constrain the frame of this view
 * @return a new rect in the coordinate system of the constraining frame (view)
 */
- (CGRect) constrainFrame:(CGRect)aFrame inFrame:(CGRect)bFrame;


@end
