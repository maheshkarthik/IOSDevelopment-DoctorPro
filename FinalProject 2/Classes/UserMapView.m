//
//  MQUserLocationSampleViewController.m
//  MQUserLocationSample
//
//  Created by Ty Beltramo on 7/19/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import "UserMapView.h"

@implementation AddressAnnotation

@synthesize coordinate;

- (NSString *)subtitle{
	return @"Sub Title";
}
- (NSString *)title{
	return @"Title";
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

@end


@implementation UserMapView

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect mapFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    //Setup the map view
    mapView = [[MQMapView alloc] initWithFrame:mapFrame];
    mapView.delegate = self;
    
    //Position the map at a point
    MQMapPoint origin = MQMapPointForCoordinate(CLLocationCoordinate2DMake(42.822842, -83.267934));
    MQMapPoint maxPt = MQMapPointForCoordinate(CLLocationCoordinate2DMake(42.754468, -83.214247));
    
    [locationSwitch setOn:mapView.showsUserLocation animated:NO];
    [headingSwitch setOn:mapView.showsHeading animated:NO];
	segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:mapView];
    [self.view sendSubviewToBack:mapView];
    
    MQMapRect rect = MQMapRectMake(origin.x, origin.y, maxPt.x - origin.x, maxPt.y - origin.y);
    
    [mapView setVisibleMapRect:rect animated:NO];
}

-(IBAction)setMapType:(id)sender {
	UISegmentedControl* control = sender;
	switch (control.selectedSegmentIndex) {
		case 1:
			mapView.mapType = MQMapTypeSatellite;
			break;
		case 2:
			mapView.mapType = MQMapTypeHybrid;
			break;
		default:
			mapView.mapType = MQMapTypeStandard;
			break;
	}
}







-(IBAction)recenterMap:(id)sender {
    //Position the map at a point
    MQMapPoint origin = MQMapPointForCoordinate(CLLocationCoordinate2DMake(42.822842, -83.267934));
    MQMapPoint maxPt = MQMapPointForCoordinate(CLLocationCoordinate2DMake(42.754468, -83.214247));
    
    MQMapRect rect = MQMapRectMake(origin.x, origin.y, maxPt.x - origin.x, maxPt.y - origin.y);
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [mapView setVisibleMapRect:rect edgePadding:insets animated:YES];
    
}

- (void)viewDidUnload
{
	
    [super viewDidUnload];
    
}


-(IBAction)toggleUserLocation:(id)sender {
    mapView.showsUserLocation = locationSwitch.on;
    
    if (mapView.showsUserLocation) {
    }
    else 
        [mapView removeAnnotations:[mapView annotations]];
}

-(IBAction)toggleHeading:(id)sender {
    mapView.showsHeading = headingSwitch.on;
}

-(MQAnnotationView*)mapView:(MQMapView *)aMapView viewForAnnotation:(id<MQAnnotation>)annotation {
    
    MQAnnotationView *pinView = nil;
    
    //Let the MapView create the view for the user location. Otherwise, it can be overridden to support custom user location views.
    if ([annotation isKindOfClass:[MQUserLocation class]]) 
        return nil;
	
    return pinView;
}





- (void)mapViewWillStartLocatingUser:(MQMapView *)mapView {
    NSLog(@"MapDelegate notified of STARTING to track user");
}


- (void)mapViewDidStopLocatingUser:(MQMapView *)mapView {
    NSLog(@"MapDelegate notified of STOPPING tracking of user");
}


- (void)mapView:(MQMapView *)amapView didUpdateUserLocation:(MQUserLocation *)userLocation {
    NSLog(@"MapDelegate notified of new user location");
    accuracyInMeters.text = [NSString stringWithFormat:@"%f m",userLocation.location.horizontalAccuracy];
    
    if (userLocation.coordinate.latitude > 0)
        [amapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

- (void)mapView:(MQMapView *)mapView didUpdateHeading:(CLHeading*)newHeading {
    NSLog(@"MapDelegate notified of new heading: %f OR %f", newHeading.trueHeading, newHeading.magneticHeading);
    headingInDegrees.text = [NSString stringWithFormat:@"%f",newHeading.trueHeading];
}

- (void)mapView:(MQMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"MapDelegate notified of location tracking error");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
