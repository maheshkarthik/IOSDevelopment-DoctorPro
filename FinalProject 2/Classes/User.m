    //
//  User.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"


@implementation User
@synthesize fname, lname, email, username,password,sex,userid;

+ (id)userWithFirstname:(NSString *)fname lname:(NSString *)lname email:(NSString *)email username:(NSString *)username password:(NSString *)password  sex:(NSString *)sex userid:userid;

{
	User  *newuser= [[[self alloc] init] autorelease];
	newuser.fname = fname;
	newuser.lname = lname;
	newuser.email = email;
	newuser.username = username;
	newuser.password = password;
	newuser.userid=userid;
	newuser.sex = sex;
	
	
	return newuser;
}


- (void)dealloc
{
	[fname release];
	[lname release];
	[email release];
	[username release];
	[password release];
    [userid release]; 
	[sex release];
	
	
	[super dealloc];
}





@end

