    //
//  Doctor.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Doctor.h"


#import "Doctor.h"


@implementation Doctor

@synthesize firstname,lastname,phno;


+(id)docWithFirstName:(NSString *)firstname lastname:(NSString *)lastname phone:(NSString *)phno{
	
	Doctor *newDoc = [[[self alloc] init] autorelease];
	newDoc.firstname = firstname;
	newDoc.lastname = lastname;
	newDoc.phno = phno;
	return newDoc;
	
}


- (void)dealloc {
	[firstname release];
	[lastname release];
	[phno release];
    [super dealloc];
}


@end
