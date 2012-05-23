//
//  MQRouteAnnotation.h
//  mq_ios_sdk
//
//  Created by Ty Beltramo on 11/23/11.
//  Copyright (c) 2011 MapQuest. All rights reserved.
//

#import "MQPointAnnotation.h"

/**Where on the route does this annotation exist
 *BEGIN
 *END
 *BETWEEN - somewhere along the route
 */
typedef enum {
    BEGIN,
    BETWEEN,
    END
} MQRelativeRoutePosition;


/** An annotatioin placed along a route, usually at start or end, but may be in the middle.
 * There can be any number of route annotations associated with a route.
 */
@interface MQRouteAnnotation : MQPointAnnotation

///This annotation's position in the order of the series of route annotations. This is zero based.
@property NSInteger index;

///This annotations relative position on the route - BEGIN, BETWEEN, or END
@property MQRelativeRoutePosition routePosition;

@end
