//
//  MapController.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MapController : UIViewController <CLLocationManagerDelegate>{
	CLLocationManager *locationManager;
	IBOutlet UIWebView *webView;

}

@end
