//
//  SpecialityViewController.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface SpecialityViewController : UITableViewController<UISearchDisplayDelegate, UISearchBarDelegate, UITextFieldDelegate> {
	NSMutableArray *specialityList;
	NSMutableArray	*filteredListContent;
    NSString *savedSearchTerm;
    NSInteger savedScopeButtonIndex;
	NSInteger row;
    BOOL searchWasActive;
	NSString *databaseName;
	NSString *databasePath;
	sqlite3 *database;
	//DrugDetailViewController *drugdetailcontroller;
}
@property (nonatomic, retain) NSMutableArray *specialityList;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) NSInteger row;
@property (nonatomic) BOOL searchWasActive;
//@property (nonatomic, retain) DrugDetailViewController *drugdetailcontroller;


-(void) readSpecialityFromDatabase;

@end
