//
//  MQTypes.h
//  mq_ios_sdk
//
//  Created by Ty Beltramo on 9/23/11.
//  Copyright (c) 2011 MapQuest. All rights reserved.
//

#import "MQFoundation.h"

enum {
    MQMapTypeStandard = 0,
    MQMapTypeSatellite,
    MQMapTypeHybrid
};
typedef NSUInteger MQMapType;


MQ_EXTERN NSString *MQErrorDomain;

enum MQErrorCode {
    MQErrorUnknown = 1,
    MQErrorServerFailure,
    MQErrorLoadingThrottled,
    MQErrorPlacemarkNotFound,
};


#ifndef mq_ios_sdk_MQTypes_h
#define mq_ios_sdk_MQTypes_h



#endif
