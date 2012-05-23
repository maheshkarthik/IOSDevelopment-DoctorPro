//
//  UserDisease.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserDisease : UIViewController {

	NSNumber *user_id;
	NSString *diseasename;
	
}

@property (nonatomic, copy) NSString *diseasename;
@property(nonatomic,copy)NSNumber *user_id;


+ (id)userdiseaseWithuser_id:(NSNumber *)user_id diseasename:(NSString *)diseasename;

@end
