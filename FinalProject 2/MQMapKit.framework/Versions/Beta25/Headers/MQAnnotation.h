//
//  MQAnnotation.h
//
//  Created by Ty Beltramo on 7/5/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>
/**
 Protocol defining the minimum content to describe an annotation
 */
@protocol MQAnnotation <NSObject>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@optional

/** Title and subtitle for callout. 
* @warning An empty title will disable user interaction for the annotation */
@property (nonatomic, readonly, copy) NSString *title;

/** @warning Will only be displayed if the title is not empty */
@property (nonatomic, readonly, copy) NSString *subtitle;

/**Must be implemented if draggable is enabled 
 @param aCoord the location in the map coordinate space */
- (void)setCoordinate:(CLLocationCoordinate2D)aCoord;

@end
