//
//  MapController.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MapController.h"


@implementation MapController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (void) viewDidLoad {
	[super viewDidLoad];
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
	locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
	[locationManager startUpdatingLocation];

	
//	NSString *url = "http://maps.google.com/?q=hospital+loc:+[lat],+[longt]";
//	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//	[webView loadRequest:request];
	
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
	int degrees = newLocation.coordinate.latitude;
	double decimal = fabs(newLocation.coordinate.latitude - degrees);
	int minutes = decimal * 60;
	double seconds = decimal * 3600 - minutes * 60;
	NSString *lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"", 
					 degrees, minutes, seconds];
	
	
	//latLabel.text = lat;
	degrees = newLocation.coordinate.longitude;
	decimal = fabs(newLocation.coordinate.longitude - degrees);
	minutes = decimal * 60;
	seconds = decimal * 3600 - minutes * 60;
	NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"", 
					   degrees, minutes, seconds];
	//longLabel.text = longt;
	//NSLog(lat);
//	NSLog(longt);
//	NSString * la = [[[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude]autorelease];
//    NSString * lo = [[[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.longitude]autorelease];

	
	
	NSString *searchString = @"Hospital";
	//NSString *tempURLString = [[NSString alloc] initWithFormat:@"http://maps.google.com/?q=hospital+loc:+42.326582,+-71.101022"];
	NSString *tempURLString = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?q=%@+loc:%f,+%f&num=4",searchString, newLocation.coordinate.latitude,newLocation.coordinate.longitude];
	NSURL *myURL = [NSURL URLWithString:tempURLString];
	NSURLRequest *req1= [NSURLRequest requestWithURL:myURL]; 
	[webView loadRequest:req1];
	
	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[locationManager release];
    [super dealloc];
}


@end
