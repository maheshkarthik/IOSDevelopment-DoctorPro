//
//  MQFoundation.h
//  mq_ios_sdk
//
//  Created by Ty Beltramo on 9/23/11.
//  Copyright (c) 2011 MapQuest. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifdef __cplusplus
#define MQ_EXTERN       extern "C" __attribute__((visibility ("default")))
#else
#define MQ_EXTERN       extern __attribute__((visibility ("default")))
#endif

#define MQ_CLASS_AVAILABLE(_macIntro, _iphoneIntro) __attribute__((visibility("default"))) NS_CLASS_AVAILABLE(_macIntro, _iphoneIntro)

#define MQ_CLASS_DEPRECATED(_macIntro,_macDep,_iphoneIntro,_iphoneDep) __attribute__((visibility("default"))) NS_DEPRECATED(_macIntro,_macDep,_iphoneIntro,_iphoneDep)


#ifndef mq_ios_sdk_MQFoundation_h
#define mq_ios_sdk_MQFoundation_h

#endif


