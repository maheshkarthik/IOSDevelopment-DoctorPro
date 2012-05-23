//
//  Speciality.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Speciality : UIViewController {

	
	NSString *speciality;
}

@property (nonatomic, copy) NSString *speciality;

+ (id)initWithSpeciality:(NSString *) speciality ;
@end
