//
//  Symptoms.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Symptoms : UIViewController {
	
	NSNumber *illnessid;
	NSString *illness;
	NSString *definition;
	NSString *symptoms;
}

@property (nonatomic,retain)NSNumber *illnessid;
@property (nonatomic,retain)NSString *illness;
@property (nonatomic,retain)NSString *definition;
@property (nonatomic,retain)NSString *symptoms;





+ (id)illnessWithid:(NSNumber *)illnessid illness:(NSString *)illness defn:(NSString *)definition symp:(NSString *)symptoms;


@end
