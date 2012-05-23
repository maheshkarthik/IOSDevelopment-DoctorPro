//
//  MQShape.h
//  mq_ios_sdk
//
//  Created by Ty Beltramo on 7/12/11.
//  Copyright 2011 MapQuest. All rights reserved.
/// This is a comment.

#import <Foundation/Foundation.h>
#import "MQAnnotation.h"

/** The parent class for objects with geometry
 */
@interface MQShape : NSObject<MQAnnotation> {
    CLLocationCoordinate2D coordinate;
}

/** Title and subtitle for callout. 
 * @warning An empty title will disable user interaction for the annotation */
@property (nonatomic, copy) NSString *title;

/** @warning Will only be displayed if the title is not empty */
@property (nonatomic, copy) NSString *subtitle;

/**
* Initialize a shape with a coord. The meaning the coordinate value is determined by the type of shape (e.g. whether it is center of the MBR for a polygon/polyline or the position of a point object.
 @param coord  A CLLocationCoordinate2D in a user-defined coordinate system.
 @param aTitle An NSString denoting the primary user-readable label of this shape
 @param aSubtitle An NSString object denoting the detailed description of this shape.

 @warning For MQAnnotation objects, an empty title will disable the callout with regard to user interaction.
 */
- (id)initWithCoordinate:(CLLocationCoordinate2D)coord 
                   title:(NSString *)aTitle 
                subTitle:(NSString*)aSubtitle;

@end
