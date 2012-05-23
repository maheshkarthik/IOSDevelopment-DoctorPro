//
//  SymptomDetailViewController.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Symptoms.h"


extern NSMutableArray *array;

@interface SymptomDetailViewController : UITableViewController {
	NSString *databaseName;
	NSString *databasePath;
	sqlite3 *database;
	NSInteger irow;
}

@property (nonatomic, retain) NSMutableArray* symptomArray;
@property (nonatomic, retain) NSString* bodyPart;
@property(nonatomic) NSInteger irow;

- (NSMutableArray*) symptomsForBodyPart:(NSString*) bodyPart;

@end
