    //
//  Symptoms.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Symptoms.h"


@implementation Symptoms

@synthesize illnessid,illness,definition,symptoms;


+ (id)illnessWithid:(NSNumber *)illnessid illness:(NSString *)illness defn:(NSString *)definition symp:(NSString *)symptoms;
{
	Symptoms *newIllness = [[[self alloc] init] autorelease];
	newIllness.illnessid = illnessid;
	newIllness.illness = illness;
	newIllness.definition=definition;
	newIllness.symptoms=symptoms;
	return newIllness;
}


- (void)dealloc
{
	[illness release];
	[definition release];
	[symptoms release];
	[super dealloc];
}


@end
