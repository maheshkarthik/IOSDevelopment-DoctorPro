//
//  UserDiseasesViewController.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UserDiseasesViewController.h"
#import "FinalProjectAppDelegate.h"
#import "UserDisease.h"
#import "SegmentViewController1.h"
#import "Symptoms.h"
#import "MyProfileViewController.h"


@implementation UserDiseasesViewController
@synthesize userdiseaselist,symptomsarray,irow;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	databaseName = @"SymDB.sql";
	
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	
	
	[self readuserdiseasesFromDatabase];
	
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



-(void) readuserdiseasesFromDatabase {
	// Setup the database object
	FinalProjectAppDelegate* delegate = (FinalProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	// Init the animals Array
	userdiseaselist = [[NSMutableArray alloc] init];
	NSLog(@"%@",delegate.userID);
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		NSString *temp = [[NSString alloc]initWithFormat:
						  @"select * from user_saveddiseases where user_id='%@'",delegate.userID];
	 
		const char *sqlStatement = [temp UTF8String];
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSNumber *user_id = [NSNumber numberWithInt:(char *)sqlite3_column_int(compiledStatement, 0)];
				
				NSString *diseasename = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				
				
				
				
				
				// Add the employee object to the animals Array
				[userdiseaselist addObject:[UserDisease userdiseaseWithuser_id:user_id diseasename:diseasename]];
				
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	//sqlite3_close(database);
	
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.userdiseaselist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	//if(indexPath.section == 0)
	//{
	
	UserDisease *us= [userdiseaselist objectAtIndex:indexPath.row];
	//cell.textLabel.text=[self.symptomArray objectAtIndex:[indexPath row]];
	cell.textLabel.text=us.diseasename;
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	//cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
	//		cell.imageView.image = [UIImage imageNamed:@"911.jpg"]; 	
	return cell;		
	//}
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(void) readsymFromDatabase:(NSString*) no {
	
	symptomsarray = [[NSMutableArray alloc] init];
	databaseName = @"SymDB.sql";
	
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		NSString *temp = [[NSString alloc]initWithFormat:
						  @"select * from illness where illness='%@'",no];
		
		const char *sqlStatement = [temp UTF8String];
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSNumber *illnessid = [NSNumber numberWithInt:sqlite3_column_int(compiledStatement, 0)];
				
				NSString *illness = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *definition = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *symptoms = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				
				[symptomsarray addObject:[Symptoms illnessWithid:illnessid illness:illness defn:definition symp:symptoms]];
				
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}		
	
	
		
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	irow = [indexPath row];
	
	/*
	 If the requesting table view is the search display controller's table view, configure the next view controller using the filtered content, otherwise use the main list.
	 */
	UserDisease *i = nil;
	
	i = [userdiseaselist objectAtIndex:indexPath.row];
	NSLog(@"%@",i.diseasename);
	
	FinalProjectAppDelegate* delegate = (FinalProjectAppDelegate*)[[UIApplication sharedApplication] delegate];

	NSLog(@"%@",delegate.userID);
	[self readsymFromDatabase:i.diseasename];
			
	Symptoms *s=nil ;
	//s=[symptomsarray objectAtIndex:0];
	//[symptomsarray addObject:[Symptoms illnessWithid:illnessid illness:@"Asthma Attack" defn:@"dd" symp:@"dd"]];
	s=[symptomsarray objectAtIndex:0];
	SegmentViewController1 * svc = [[SegmentViewController1 alloc] initWithIllness:(Symptoms *)s num:(NSInteger)irow];
	
	
	[self.navigationController pushViewController:svc animated:YES];

	[self.tableView reloadData];
   [svc release];
	
	
	



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
	[userdiseaselist release];
	
    [super dealloc];
}




@end
