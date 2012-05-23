//
//  Doctor.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Doctor : UIViewController {
	
	NSString *firstname;
	NSString *lastname;
	NSString *phno;
	
}
@property(nonatomic,retain) NSString *firstname;
@property(nonatomic,retain)NSString *lastname;
@property(nonatomic,retain)NSString *phno;

+(id)docWithFirstName:(NSString *)firstname lastname:(NSString *)lastname phone:(NSString *)phno;

@end
