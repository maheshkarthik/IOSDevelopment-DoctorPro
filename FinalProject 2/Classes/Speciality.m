    //
//  Speciality.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Speciality.h"


@implementation Speciality
@synthesize speciality;

+ (id)initWithSpeciality:(NSString *) speciality{
	
	Speciality *sp = [[[self alloc] init] autorelease];
	sp.speciality = speciality;
	
	return sp;
	
}


- (void)dealloc {
	[speciality release];
    [super dealloc];
}


@end
