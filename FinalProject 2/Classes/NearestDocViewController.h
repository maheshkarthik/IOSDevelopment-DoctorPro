//
//  NearestDocViewController.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NearestDocViewController:UIViewController <CLLocationManagerDelegate>{
	CLLocationManager *locationManager;
    IBOutlet UIWebView *webView;
	NSString *speciality;
}


@property (nonatomic, retain) NSString* speciality;

- (void) nearestdoctor:(NSString*) speciality;

@end
