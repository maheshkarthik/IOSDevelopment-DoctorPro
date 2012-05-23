//
//  MyProfileViewController.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MyProfileViewController.h"
#import "User.h"
#import "FinalProjectAppDelegate.h"

@implementation MyProfileViewController

@synthesize userName,password,loginbutton,indicator,userlist,rvc,mphc,adBannerView;

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	databaseName = @"SymDB.sql";
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];

	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
    [super viewDidLoad];
	self.title=@"My Profile";
	
		
	
	[self readUsersFromDatabase];

	
}


- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self adjustBannerView];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self adjustBannerView];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    //TO DO
    //Check internet connecction here
    /*
	 if(internetNotAvailable)
	 {
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet." message:@"Please make sure an internet connection is available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	 [alert show];
	 [alert release];
	 return NO;
	 }*/
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    
}


-(void) readUsersFromDatabase {
	// Setup the database object
	sqlite3 *database;
	
	// Init the employees Array
	userlist = [[NSMutableArray alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from user";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSNumber *userid = [NSNumber numberWithInt:(char *)sqlite3_column_int(compiledStatement, 0)];
				NSString *fname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *lname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *email = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				NSString *username = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
				NSString *passwordd = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
				NSString *sex = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
				
				
				// Add the student object to the animals Array
				[userlist addObject:[User userWithFirstname:fname lname:lname email:email username:username password:passwordd  sex:sex userid:userid]];
				
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	
	return YES;
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



- (void)dealloc {
    [super dealloc];
}

- (void) viewWillAppear:(BOOL)animated {
	FinalProjectAppDelegate* delegate = (FinalProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	if (delegate.isLoggedIn) {
		MyProfileHomePage* homeVC = [[MyProfileHomePage alloc] initWithNibName:@"MyProfileHomePage" bundle:nil];
		[self.navigationController pushViewController:homeVC animated:YES];
		[homeVC release];
	}
}

- (IBAction) loginButton: (id) sender
{
	bool flag=false;
	indicator.hidden = FALSE;
	[indicator startAnimating];
	
	loginbutton.enabled = FALSE;
	
	
	if(([userName.text length]>0) && ([password.text length]>0))
	{
		for (User *u in userlist) 
		{
			NSString *username = userName.text;
			NSString *passwordd = password.text;
			NSLog(@"%@",username);
			if(([u.username isEqualToString:username]) && ([u.password isEqualToString:passwordd]))
			{
			
				flag=true;
				
				FinalProjectAppDelegate* delegate = (FinalProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
				delegate.isLoggedIn = true;
				delegate.userID=u.userid;
				
				
				
				mphc = [[MyProfileHomePage alloc]initWithNibName:@"MyProfileHomePage" bundle:nil];
				[self.navigationController pushViewController:mphc animated:YES];
				[mphc release];
				
							}
			
		}
		if(flag==false)
		{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"username and pwd is not correct" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		}
			
	}
}

- (IBAction) regButton: (id) sender
{
	rvc = [[RegistrationViewController alloc]initWithNibName:@"RegistrationViewController" bundle:nil];
    [self.navigationController pushViewController:rvc animated:YES];
    [rvc release];
	
	
}



@end
