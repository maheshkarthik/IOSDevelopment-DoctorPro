//
//  AddDoctorViewController.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <sqlite3.h> // Import the SQLite database framework
#import "Doctor.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@interface AddDoctorViewController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate,ABPeoplePickerNavigationControllerDelegate> {
	
	IBOutlet UITextField *fname;
	IBOutlet UITextField *lname;
	IBOutlet UITextField *pno;
	
	NSString *databaseName;
	NSString *databasePath;
	sqlite3 *database;
	Doctor *doc;
	
	
	UIBarButtonItem *_addButton;
	
}
@property(nonatomic,retain)IBOutlet UITextField *fname;
@property(nonatomic,retain)IBOutlet UITextField *lname;
@property(nonatomic,retain)IBOutlet UITextField *pno;


-(void) readStudentsFromDatabase;
@end
