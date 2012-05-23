//
//  DetailsViewController.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Symptoms.h"
#import <sqlite3.h> // Import the SQLite database framework
#import "DiagnosisViewController.h"
#import "ImageViewController.h"


extern 	NSMutableArray *imglist;
@interface DetailsViewController : UITableViewController {
	NSInteger rowid;
	ImageViewController *imageController;
	Symptoms *illness;
	NSString *databaseName;
	NSString *databasePath;
	sqlite3 *database;
	NSInteger row;
	DiagnosisViewController *diagnosisController;
}
@property (nonatomic) NSInteger row;
@property (nonatomic, retain) ImageViewController *imageController;
@property (nonatomic, retain) DiagnosisViewController *diagnosisController;
@property(nonatomic,retain)Symptoms *illness;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil illn:(Symptoms *)ill num:(NSInteger)row;

@end
