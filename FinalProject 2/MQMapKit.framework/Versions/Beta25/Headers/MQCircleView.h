//
//  MQCircleView.h
//  mq_ios_sdk
//
//  Created by Erik Scrafford on 8/9/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQOverlayPathView.h"
#import "MQCircle.h"

///The view for an MQCircle type of overlay
@interface MQCircleView : MQOverlayPathView {
    MQCircle *m_circle;
}

///Circle object to represent
@property (nonatomic, readonly) MQCircle *circle;

/**Init view with a circle object
 * @param circle The circle overlay to draw
 */
- (id)initWithCircle:(MQCircle *)circle;


@end
