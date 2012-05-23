//
//  AddDoctorViewController.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AddDoctorViewController.h"
#import "Doctor.h"


@implementation AddDoctorViewController

@synthesize fname,lname,pno;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}


-(void) viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	fname.delegate=self;
	lname.delegate=self;
	pno.delegate=self;
	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	self.title =@"Doctor details";
	
	
	
	databaseName = @"SymptomDatabase.sql";
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	
	
	// Query the database for all animal records and construct the "animals" array
	[self readStudentsFromDatabase];
	
	if(doc!=nil)
	{
		[fname setEnabled: NO];
		[lname setEnabled: NO];
		[pno setEnabled: NO];
		fname.text = doc.firstname;
		lname.text = doc.lastname;
		pno.text = doc.phno;
		_addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editDoc:)];	
		[[self navigationItem] setRightBarButtonItem:_addButton];
	}
	else{
		
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose an option" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil  otherButtonTitles:nil];
		[actionSheet addButtonWithTitle:@"Import from contacts"];
		[actionSheet addButtonWithTitle:@"Cancel"];	
		actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
		[actionSheet showInView:self.view];
		[actionSheet release];
		[fname setEnabled: YES];
		[lname setEnabled: YES];
		[pno setEnabled: YES];
		_addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(addDoc:)];	
		[[self navigationItem] setRightBarButtonItem:_addButton];
	}
	
	
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {
		
		ABPeoplePickerNavigationController *picker =
		
		[[ABPeoplePickerNavigationController alloc] init];
		
		picker.peoplePickerDelegate = self;
		
		
		
		[self presentModalViewController:picker animated:YES];
		
		[picker release];
    } 
	
}

- (void)peoplePickerNavigationControllerDidCancel:

(ABPeoplePickerNavigationController *)peoplePicker {
	
    [self dismissModalViewControllerAnimated:YES];
	
}

- (BOOL)peoplePickerNavigationController:

(ABPeoplePickerNavigationController *)peoplePicker

      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
	
	
	
    NSString* name = (NSString *)ABRecordCopyValue(person,
												   
												   kABPersonFirstNameProperty);
	
    self.fname.text = name;
	
    [name release];
	
	
	
    name = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
	
    self.lname.text = name;
	
    [name release];
	
	
	
	ABMultiValueRef phoneNumbers =(NSString*)ABRecordCopyValue(person,kABPersonPhoneProperty);
	
	for(CFIndex i=0;i<ABMultiValueGetCount(phoneNumbers);i++)
	{
		NSString *value = (NSString*)ABMultiValueCopyValueAtIndex(phoneNumbers,i);
		NSLog(@"value :%@",value);
		self.pno.text = value;
		break;
	}
	
	
    [self dismissModalViewControllerAnimated:YES];
	
	
	
    return NO;
	
}



- (BOOL)peoplePickerNavigationController:

(ABPeoplePickerNavigationController *)peoplePicker

      shouldContinueAfterSelectingPerson:(ABRecordRef)person

                                property:(ABPropertyID)property

                              identifier:(ABMultiValueIdentifier)identifier{
	
    return NO;
	
}


-(void) readStudentsFromDatabase {
	// Setup the database object
	
	// Init the  Array
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from doc";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSString *finame = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				NSString *laname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *phno = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				
				doc = [Doctor docWithFirstName:finame lastname:laname phone:phno];
				
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	//sqlite3_close(database);
	
}
-(void)addDoc:(id)sender{
	
	[fname setEnabled: NO];
	[lname setEnabled: NO];
	[pno setEnabled: NO];
	NSString *fn = self.fname.text;
	NSString *ln = self.lname.text;
	NSString *n = self.pno.text ;
	if(doc==nil)
	{
		NSString *temp = [[NSString alloc]initWithFormat:@"insert into doc values('%@','%@','%@')",fn,ln,n];
		const char *sql = [temp UTF8String];
		sqlite3_stmt *statement;
		
		if (sqlite3_prepare_v2(database, sql, -1, &statement, nil) == SQLITE_OK)
		{
			if(SQLITE_DONE!=sqlite3_step(statement))
			{
				NSAssert1(0,@"Error by inserting '%s'",sqlite3_errmsg(database));
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"OOPS Error while inserting!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release]; 
				
			}
			else
			{
				sqlite3_finalize(statement);
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Doctor added successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];
				
				
			}
		}
	}
	else{
		
		NSString *temp = [[NSString alloc]initWithFormat:@"Update doc set fname='%@',lname='%@',pno='%@'",fn,ln,n];
		const char *sql = [temp UTF8String];
		sqlite3_stmt *statement;
		
		if (sqlite3_prepare_v2(database, sql, -1, &statement, nil) == SQLITE_OK)
		{
			if(SQLITE_DONE!=sqlite3_step(statement))
			{
				NSAssert1(0,@"Error while trying to update '%s'",sqlite3_errmsg(database));
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"OOPS Error while updating!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release]; 
				
			}
			else
			{
				sqlite3_finalize(statement);
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Details updated successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];
				
				
			}
		}
		
	}
	_addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editDoc:)];	
	[[self navigationItem] setRightBarButtonItem:_addButton];
	
	
}

-(void)editDoc:(id)sender{
	
	[fname setEnabled: YES];
	[lname setEnabled: YES];
	[pno setEnabled: YES];
	_addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(addDoc:)];	
	[[self navigationItem] setRightBarButtonItem:_addButton];
}



/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	
	return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	sqlite3_close(database);
	[_addButton release];
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
