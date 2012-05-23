//
//  MQPinAnnotationView.h
//  mq_ios_sdk
//
//  Created by Administrator on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MQAnnotationView.h"
#import <QuartzCore/QuartzCore.h>

///Colors for the pin icon
enum {
    MQPinAnnotationColorRed = 0,
    MQPinAnnotationColorGreen,
    MQPinAnnotationColorPurple
} typedef  MQPinAnnotationColor;

///Hints to the view which image, if multiple are aviable, to show during drop animation
enum {
    MQPinAnnotationDropStatusUp,
    MQPinAnnotationDropStatusDown
} typedef MQPinAnnotationDropStatus;

/**
 A default view that shows a pin with a shadow. 
 
 The placemen of the pin may be animated by setting the animatesDrop flag.
 The color of the pin can be set via the pinColor property.
 */
@interface MQPinAnnotationView : MQAnnotationView<UIGestureRecognizerDelegate> {
}

///When dispaying for the first time, animate the drop of the pin 
@property (nonatomic) BOOL animatesDrop;

///The color of the pin to use: Red, Green, Purple
@property (nonatomic) MQPinAnnotationColor pinColor;

///The shadow view. Attached here to support drag operations and to enable the MQPinAnnotationView instance to hide its own shadow when necessary. This can be set to nil to hide the shadow
@property (nonatomic, retain) UIImageView* shadowLayer;

///Do not set directly. 
@property (nonatomic) MQPinAnnotationDropStatus pinDropStatus;


@end
