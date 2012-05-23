//
//  MQUserLocationView.h
//  mq_ios_sdk
//
//  Created by Ty Beltramo on 7/20/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQAnnotationView.h"
#import <QuartzCore/QuartzCore.h>
#import "MQCircleLayer.h"

/** A special annotation view that is reserved to represent the view of user's current location on a map
 */
@interface MQUserLocationView : MQAnnotationView {
    UIImage *iconImage;
    CALayer *iconLayer;
    MQCircleLayer *circleLayer;
    CGFloat accuracyInMeters;
}

///The level of accuracy represented in meters
@property (nonatomic) CGFloat accuracyInMeters;

@end
