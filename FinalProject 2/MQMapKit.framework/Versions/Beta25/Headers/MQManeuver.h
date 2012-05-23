//
//  MQManeuver.h
//  mq_ios_sdk
//
//  Created by Erik on 11/3/11.
//  Copyright (c) 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  enum {
    MQManeuverEnd = -1,
    MQManeuverStraight = 0,
    MQManeuverSlightRight = 1,
    MQManeuverRight = 2,
    MQManeuverSharpRight = 3,
    MQManeuverReverse = 4,
    MQManeuverSharpLeft = 5,
    MQManeuverLeft = 6,
    MQManeuverSlightLeft = 7,
    MQManeuverRightUTurn = 8,
    MQManeuverLeftUTurn = 9,
    MQManeuverRightMerge = 10,
    MQManeuverLeftMerge = 11,
    MQManeuverRightOnRamp = 12,
    MQManeuverLeftOnRamp = 13,
    MQManeuverRightOffRamp = 14,
    MQManeuverLeftOffRamp = 15,
    MQManeuverRightFork = 16,
    MQManeuverLeftFork = 17,
    MQManeuverStraightFork = 18,
    MQManeuverTypeUndefined = 19
} MQManeuverType;

/*
 end = -1
 straight = 0
 slight right = 1
 right = 2
 sharp right = 3
 reverse = 4
 sharp left = 5
 left = 6
 slight left = 7
 right u-turn = 8
 left u-turn =9
 right merge =10
 left merge = 11
 right on ramp = 12
 left on ramp = 13
 right off ramp = 14
 left off ramp = 15
 right fork = 16
 left fork = 17
 straight fork = 18
 */

typedef enum {
    MQManeuverDirectionNone = 0,
    MQManeuverDirectionN = 1,
    MQManeuverDirectionNW = 2,
    MQManeuverDirectionNE = 3,
    MQManeuverDirectionS = 4,
    MQManeuverDirectionSE = 5,
    MQManeuverDirectionSW = 6,
    MQManeuverDirectionW = 7,
    MQManeuverDirectionE = 8
} MQManeuverDirection;

/*
none = 0
north = 1
northwest = 2
northeast = 3
south = 4
southeast= 5
southwest = 6
west = 7
east = 8
*/
/**A maneuver along a route
 *
 */
@interface MQManeuver : NSObject

///The description of the maneuver in human readable text
@property (retain) NSString *narrative;

///The string for the URL for the badge that shows the type of maneuver
@property (retain) NSString *iconURLString;

///The string for the url that shows how to display the manuever on a map
@property (retain) NSString *mapURLString;

///The duratation of the maneuver 
@property NSTimeInterval duration;

///The distance of the maneuver
@property float distance;

///The type of turn indicated by the maneuver
@property MQManeuverType turnType;

///The eight point direction of the maneuver
@property MQManeuverDirection turnDirection;

@end
