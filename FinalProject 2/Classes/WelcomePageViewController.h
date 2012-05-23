//
//  WelcomePageViewController.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SymptomsViewController.h"
#import "HotLineViewController.h"
#import "SpecialityViewController.h"
#import "AppointmentViewController.h"
#import "MapController.h"
#import "UserMapView.h"

@interface WelcomePageViewController : UIViewController {
	
	SymptomsViewController *svc;
	HotLineViewController *hvc;
	SpecialityViewController *dvc;
	MapController *mvc;
	AppointmentViewController *avc;
	UserMapView *umv;
	
	
	
}
@property(nonatomic,retain)SymptomsViewController *svc;
@property(nonatomic,retain)HotLineViewController *hvc;
@property(nonatomic,retain)SpecialityViewController *dvc;
@property(nonatomic,retain)MapController *mvc;
@property(nonatomic,retain)AppointmentViewController *avc;
@property(nonatomic,retain)UserMapView *umv;



- (IBAction)enterApp:(id)sender;
- (IBAction)enterHotLine:(id)sender;
- (IBAction)enterDoctors:(id)sender;
- (IBAction)enterLocation:(id)sender;
- (IBAction)grabURL:(id)sender;
- (IBAction)appointment:(id)sender;
- (IBAction)UserMapView:(id)sender;

- (NSString*) getUserDocumentsDirectoryByUrl:(NSString*) strUrl;
- (NSString*) getUserDocumentsDirectoryByName:(NSString*) fileName;



@end
