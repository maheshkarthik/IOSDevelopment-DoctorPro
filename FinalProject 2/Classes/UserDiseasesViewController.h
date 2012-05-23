//
//  UserDiseasesViewController.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "UserDisease.h"
#import "Symptoms.h"


@interface UserDiseasesViewController : UITableViewController  {
	
	NSMutableArray	*userdiseaselist;
	NSMutableArray *symptomsarray;
	NSString *databaseName;
	NSString *databasePath;
	sqlite3 *database;
	NSInteger irow;
	

}

@property(nonatomic) NSInteger irow;
@property(nonatomic,retain) NSMutableArray  *userdiseaselist,*symptomsarray;

-(void) readuserdiseasesFromDatabase;
-(void) readsymFromDatabase:(NSString*) no;

@end
