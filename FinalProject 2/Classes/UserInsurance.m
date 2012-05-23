    //
//  UserInsurance.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UserInsurance.h"


@implementation UserInsurance

@synthesize user_id, insurancename, plan;

+ (id)userinsuranceWithuser_id:(NSNumber *)user_id insurancename:(NSString *)insurancename plan:(NSString *)plan
{
	UserInsurance  *newuserin= [[[self alloc] init] autorelease];
	newuserin.user_id = user_id;
	newuserin.insurancename = insurancename;
	newuserin.plan = plan;
	
	return newuserin;
}


- (void)dealloc
{
	[user_id release];
	[insurancename release];
	[plan release];
	
	[super dealloc];
	
}
@end
