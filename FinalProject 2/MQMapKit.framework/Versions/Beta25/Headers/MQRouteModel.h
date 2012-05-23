//
//  MQRouteModel.h
//  mq_ios_sdk
//
//  Created by Erik on 10/31/11.
//  Copyright (c) 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MQGeometry.h"

@interface MQRouteModel : NSObject
{
    NSString *m_sessionID;
    MQCoordinateRegion m_boundingBox;
    NSMutableArray *m_shapePoints;
    NSMutableArray *m_maneuvers;
}

@property (retain) NSString *sessionID;
@property (readonly) NSArray *maneuvers;
@property  MQCoordinateRegion boundingBox;
@property (readonly) NSArray *shapePoints;

-(void)addShapePoint:(CLLocation *)routeShape;


@end
