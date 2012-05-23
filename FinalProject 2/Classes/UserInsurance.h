//
//  UserInsurance.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserInsurance : UIViewController {

	NSNumber *user_id;
	NSString *insurancename;
	NSString *plan;
}

@property (nonatomic, copy) NSString *insurancename,*plan;
@property(nonatomic,copy)NSNumber *user_id;


+ (id)userinsuranceWithuser_id:(NSNumber *)user_id insurancename:(NSString *)insurancename plan:(NSString *)plan;

@end
