//
//  MQUserLocationSampleViewController.h
//  MQUserLocationSample
//
//  Created by Ty Beltramo on 7/19/11.
//  Copyright 2011 MapQuest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MQMapKit/MQMapKit.h>

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	
	NSString *mTitle;
	NSString *mSubTitle;
}

@end

///An internal class to demonstrate the User Location functionality of the MQMapView
@interface UserMapView : UIViewController<MQMapViewDelegate,MKMapViewDelegate> {
    MQMapView *mapView;
	IBOutlet MKMapView *map1View;
    IBOutlet UISwitch *locationSwitch;
    IBOutlet UILabel *accuracyInMeters;
    
    IBOutlet UISwitch *headingSwitch;
    IBOutlet UILabel *headingInDegrees;
	
	IBOutlet UITextField *addressField;
	IBOutlet UIButton *goButton;
	
    IBOutlet UISegmentedControl *segmentedControl;
	AddressAnnotation *addAnnotation;
}

- (IBAction) showAddress;


-(IBAction)toggleUserLocation:(id)sender;
-(IBAction)toggleHeading:(id)sender;
-(IBAction)recenterMap:(id)sender;
-(IBAction)setMapType:(id)sender;

@end
