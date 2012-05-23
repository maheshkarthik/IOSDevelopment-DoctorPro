    //
//  UserDisease.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UserDisease.h"


@implementation UserDisease

@synthesize user_id, diseasename;

+ (id)userdiseaseWithuser_id:(NSNumber *)user_id diseasename:(NSString *)diseasename
{
	UserDisease  *newuserin= [[[self alloc] init] autorelease];
	newuserin.user_id = user_id;
	newuserin.diseasename = diseasename;
	
	
	return newuserin;
}


- (void)dealloc
{
	[user_id release];
	[diseasename release];
	
	[super dealloc];
	
}
@end
