//
//  MQPolylineView.h
//  mq_ios_sdk
//
//  Created by Erik Scrafford on 8/9/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQOverlayPathView.h"
#import "MQPolyline.h"

///The view for an MQPolyline type of overlay
@interface MQPolylineView : MQOverlayPathView {
    
}

///polyline represented by the view
@property (nonatomic, readonly) MQPolyline *polyline;

/**initializer with polyline object
 * @param polyline polyline object
 */
- (id)initWithPolyline:(MQPolyline *)polyline;


@end
