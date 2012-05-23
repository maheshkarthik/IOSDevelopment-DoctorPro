//
//  MyInsuranceController.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MyInsuranceController.h"
#import "UserInsurance.h"
#import "FinalProjectAppDelegate.h" 
#import "MyProfileHomePage.h"
#import "MyProfileViewController.h"


@implementation MyInsuranceController

@synthesize insurancename,insurancenamelabel,plan,planlabel,userinsurancelist;

NSString *initialText;

-(IBAction) close: (id) sender {
	[self.navigationController popViewControllerAnimated:YES];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil initialText:(NSString *)txt {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		initialText = txt;
    }
    return self;
}
- (void)viewDidLoad {
	    [super viewDidLoad];
	FinalProjectAppDelegate* delegate = (FinalProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	databaseName = @"SYmDB.sql";
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	[self readuserinsuranceFromDatabase];
	
	for (UserInsurance *ui in userinsurancelist)
	{
		if([ui.user_id isEqual:delegate.userID])
		{
			insurancename.text=ui.insurancename;
			plan.text=ui.plan;
		}
		
	}

	
		[super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
	
	UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] 
									  initWithTitle:@"Logout"                                            
									  style:UIBarButtonItemStyleBordered 
									  target:self action:@selector(Logout:)];
	self.navigationItem.rightBarButtonItem = addButtonItem;
	[addButtonItem release];
	
	FinalProjectAppDelegate* delegate = (FinalProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	if(delegate.isLoggedIn==false)
	{
		MyProfileViewController* mVC = [[MyProfileViewController alloc]initWithNibName:@"MyProfileViewController" bundle:nil];
		[self.navigationController pushViewController:mVC animated:YES];
		[mVC release];
	}
}

- (void)Logout:(id)sender{
	
	
	FinalProjectAppDelegate* delegate = (FinalProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	delegate.isLoggedIn=false;
	delegate.userID=0;
	MyProfileViewController* mVC = [[MyProfileViewController alloc]initWithNibName:@"MyProfileViewController" bundle:nil];
    [self.navigationController pushViewController:mVC animated:YES];
    [mVC release];	
}





-(void) readuserinsuranceFromDatabase
{
	userinsurancelist = [[NSMutableArray alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from user_insurance";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSNumber *user_id = [NSNumber numberWithInt:(char *)sqlite3_column_int(compiledStatement, 0)];
				NSString *insurancename1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *plan1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				
				
				
				
				
				
				// Add the employee object to the animals Array
				[userinsurancelist addObject:[UserInsurance userinsuranceWithuser_id:user_id insurancename:insurancename1 plan:plan1]];
				
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	//sqlite3_close(database);
	
}


	


- (IBAction) addoreditButton: (id) sender
{
	FinalProjectAppDelegate* delegate = (FinalProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	if(([insurancename.text length]>0) && ([plan.text length]>0))
	{
		
		
		NSString *insurancename1 = insurancename.text;
		NSString *plan1 = plan.text;
		
		
	
		int flag = 0;
		
		for (UserInsurance *ui in userinsurancelist) 
		{
			
			if([ui.user_id isEqual:delegate.userID]){
				
				flag = 1;
			}
			
		}
		if(flag==0)
		{
			
			
			NSString *temp = [[NSString alloc]initWithFormat:@"insert into user_insurance values('%@','%@','%@')",delegate.userID,insurancename1,plan1];
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
					[userinsurancelist addObject:[UserInsurance userinsuranceWithuser_id:delegate.userID insurancename:insurancename1 plan:plan1]];

					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Insurance added successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
					[alert show];
					[alert release];
					//[self.View reloadData];
					
					
				}
			}		
			
		}
		
		else{
			NSString *temp = [[NSString alloc]initWithFormat:@"UPDATE user_insurance SET insurancename = '%@',plan = '%@' WHERE user_id='%@'",insurancename1,plan1,delegate.userID];
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
					[userinsurancelist addObject:[UserInsurance userinsuranceWithuser_id:delegate.userID insurancename:insurancename1 plan:plan1]];
					
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Insurance updated successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
					[alert show];
					[alert release];
					//[self.View reloadData];
					
					
				}
				
	    }	
		
	}
	
	}
	
	else{
		
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please fill all the fields to continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release]; 
		
	}
	
}



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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
