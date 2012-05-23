//
//  MQPointAnnotation.h
//  mq_ios_sdk
//
//  Created by Ty on 7/6/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import "MQAnnotation.h"
#import "MQShape.h"

/**
 An annotation represented by a coordinate as a single point on a map.
 
 This class may be used as a default annotation if there is no need for additional behavior
 */
@interface MQPointAnnotation : MQShape<NSCopying>
{
   
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
