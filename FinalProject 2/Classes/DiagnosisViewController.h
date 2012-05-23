//
//  DiagnosisViewController.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>
#import "Symptoms.h"
#import <sqlite3.h> // Import the SQLite database framework





@interface DiagnosisViewController : UITableViewController {
	
	Symptoms *illn;
	NSString *databaseName;
	NSString *databasePath;
	sqlite3 *database;
	
	
	
	
}

@property(nonatomic, retain) Symptoms *illn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ill:(Symptoms *)illness;

@end

