//
//  User.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User :UIViewController {
	NSNumber *userid;
	NSString *fname;
	NSString *lname;
	NSString *email;
	NSString *username;
	NSString *password;

	NSString *sex;
}

@property (nonatomic, copy) NSString *fname, *lname, *email, *username,*password,*sex;
@property(nonatomic,copy)NSNumber *userid;


+ (id)userWithFirstname:(NSString *)fname lname:(NSString *)lname email:(NSString *)email username:(NSString *)username password:(NSString *)password  sex:(NSString *)sex userid:userid;

@end

