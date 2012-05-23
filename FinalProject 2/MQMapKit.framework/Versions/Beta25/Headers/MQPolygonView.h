//
//  MQPolygonView.h
//  mq_ios_sdk
//
//  Created by Erik Scrafford on 8/9/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQOverlayPathView.h"
#import "MQPolygon.h"

///The view for an MQPolygon type of overlay.
@interface MQPolygonView : MQOverlayPathView {
    
}

///Polygon represented by this view
@property (nonatomic, readonly) MQPolygon *polygon;

/**init view with a polygon object
 * @param polygon polygon object this view will represent
 * @return new MQPolygonView
 */
- (id)initWithPolygon:(MQPolygon *)polygon;


@end
