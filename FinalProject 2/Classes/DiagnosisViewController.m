//
//  DiagnosisViewController.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DiagnosisViewController.h"


@implementation DiagnosisViewController
@synthesize illn;



// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ill:(Symptoms *)illness
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		
		self.illn=illness;
		NSString *check = illn.illness;
		NSLog(@"checking here '%@'",check);
		
	}
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[super viewDidLoad];
	self.title =@"Select the symptom that applies (tap)";
	
	// Get the path to the documents directory and append the databaseName
	databaseName = @"SymDB.sql";
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	if(sqlite3_open([databasePath UTF8String], &database) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to open db with message '%s'.", sqlite3_errmsg(database));
	}
}

-(void)viewDidAppear:(BOOL)animated{
	[self.tableView flashScrollIndicators]; 	
	
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 4;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	
	if(section==0)
	{
		NSNumber *myno = illn.illnessid;
		NSInteger illid = [myno integerValue];	
		NSLog(@"DVC '%d'",illid);
		
		NSMutableArray *erlist = [[NSMutableArray alloc] init];
		
		// Setup the SQL Statement and compile it for faster access
		NSString *temp = [[NSString alloc]initWithFormat:@"select ec.emergency from emergency_condition ec,illness i,illness_emergency ie where ec.e_id=ie.e_id and i.i_id=ie.i_id and i.i_id = '%d'",illid];
		const char *sqlStatement = [temp UTF8String];
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
		{
			// Loop through the results and add them to the array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{
				// Read the data from the result row
				NSString *er = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				
				[erlist addObject:er];
				int x = [erlist count];
				NSLog(@"ERList count is '%d'",x);
			}
			
		}
		sqlite3_finalize(compiledStatement);
		
		[temp release];
		return[erlist count];
	}
	
	else if(section==1)
	{
		
		NSNumber *myno = illn.illnessid;
		NSInteger illid = [myno integerValue];	
		
		NSMutableArray *erlist = [[NSMutableArray alloc] init];
		
		// Setup the SQL Statement and compile it for faster access
		NSString *temp = [[NSString alloc]initWithFormat:@"select cd.calldoc from calldoc cd,illness i,illness_calldoc ic where cd.ci_id=ic.ci_id and i.i_id=ic.i_id and i.i_id = '%d'",illid];
		const char *sqlStatement = [temp UTF8String];
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
		{
			// Loop through the results and add them to the array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{
				// Read the data from the result row
				NSString *er = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				
				[erlist addObject:er];
				int x = [erlist count];
				NSLog(@"ERList count is '%d'",x);
			}
			
		}
		sqlite3_finalize(compiledStatement);
		
		[temp release];
		return[erlist count];
		
	}
	
	else if(section == 2){
		
		
		NSNumber *myno = illn.illnessid;
		NSInteger illid = [myno integerValue];	
		
		NSMutableArray *erlist = [[NSMutableArray alloc] init];
		
		// Setup the SQL Statement and compile it for faster access
		NSString *temp = [[NSString alloc]initWithFormat:@"select co.consultdoc from consultdoc co,illness i,illness_consultdoc ico where co.co_id=ico.co_id and i.i_id=ico.i_id and i.i_id = '%d'",illid];
		const char *sqlStatement = [temp UTF8String];
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
		{
			// Loop through the results and add them to the array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{
				// Read the data from the result row
				NSString *er = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				
				[erlist addObject:er];
				int x = [erlist count];
				NSLog(@"ERList count is '%d'",x);
			}
			
		}
		sqlite3_finalize(compiledStatement);
		
		[temp release];
		return[erlist count];
		
		
	}
	
	else{
		return 1;
	}
	
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if(section == 0)
	{
		// create the parent view that will hold header Label
		UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
		
		// create the button object
		UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		headerLabel.backgroundColor = [UIColor lightGrayColor];
		headerLabel.opaque = NO;
		headerLabel.textColor = [UIColor blackColor];
		headerLabel.highlightedTextColor = [UIColor whiteColor];
		headerLabel.font = [UIFont boldSystemFontOfSize:20];
		headerLabel.frame = CGRectMake(0.0, 0.0, 400.0, 22.0);
		
		// If you want to align the header text as centered
		// headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
		
		headerLabel.text = @"Call 911 when"; // i.e. array element
		[customView addSubview:headerLabel];
		
		return customView;
	}
	
	else if(section == 1)
	{
		// create the parent view that will hold header Label
		UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
		
		// create the button object
		UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		headerLabel.backgroundColor = [UIColor lightGrayColor];
		headerLabel.opaque = NO;
		headerLabel.textColor = [UIColor blackColor];
		headerLabel.highlightedTextColor = [UIColor whiteColor];
		headerLabel.font = [UIFont boldSystemFontOfSize:20];
		headerLabel.frame = CGRectMake(0.0, 0.0, 400.0, 22.0);
		
		// If you want to align the header text as centered
		// headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
		
		headerLabel.text = @"Go to Emergency when"; // i.e. array element
		[customView addSubview:headerLabel];
		
		return customView;
	}
	else if(section == 2)
	{
		// create the parent view that will hold header Label
		UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
		
		// create the button object
		UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		headerLabel.backgroundColor = [UIColor lightGrayColor];
		headerLabel.opaque = NO;
		headerLabel.textColor = [UIColor blackColor];
		headerLabel.highlightedTextColor = [UIColor whiteColor];
		headerLabel.font = [UIFont boldSystemFontOfSize:20];
		headerLabel.frame = CGRectMake(0.0, 0.0, 400.0, 22.0);
		
		// If you want to align the header text as centered
		// headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
		
		headerLabel.text = @"Consult your doctor when"; // i.e. array element
		[customView addSubview:headerLabel];
		
		return customView;
	}
    else{
		// create the parent view that will hold header Label
		UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
		
		// create the button object
		UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		headerLabel.backgroundColor = [UIColor lightGrayColor];
		headerLabel.opaque = NO;
		headerLabel.textColor = [UIColor blackColor];
		headerLabel.highlightedTextColor = [UIColor whiteColor];
		headerLabel.font = [UIFont boldSystemFontOfSize:20];
		headerLabel.frame = CGRectMake(0.0, 0.0, 400.0, 22.0);
		
		// If you want to align the header text as centered
		// headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
		
		headerLabel.text = @"Care Instructions"; // i.e. array element
		[customView addSubview:headerLabel];
		
		return customView;
	}
	
	
	
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 22.0;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if(section == 0)
		return @"Call 911 when";
	else if(section == 1)
		return @"Go to Emergency when";
	else if(section == 2)
		return @"Consult your doctor when";
	else
		return @"Care Instructions";
	
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	if(indexPath.section == 0)
	{
		
		NSNumber *myno = illn.illnessid;
		NSInteger illid = [myno integerValue];	
		
		NSMutableArray *erlist = [[NSMutableArray alloc] init];
		
		// Setup the SQL Statement and compile it for faster access
		NSString *temp = [[NSString alloc]initWithFormat:@"select ec.emergency from emergency_condition ec,illness i,illness_emergency ie where ec.e_id=ie.e_id and i.i_id=ie.i_id and i.i_id = '%d'",illid];
		const char *sqlStatement = [temp UTF8String];
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
		{
			// Loop through the results and add them to the array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{
				// Read the data from the result row
				NSString *er = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				
				[erlist addObject:er];
				
			}
			
			
		}
		sqlite3_finalize(compiledStatement);
		
		[temp release];
		
		cell.textLabel.text =[erlist objectAtIndex:indexPath.row];
		cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		cell.imageView.image = [UIImage imageNamed:@"911.jpg"]; 
		
		
		[erlist release];
		return cell;
		
		
	}
	
	else if(indexPath.section == 1)
	{
		NSNumber *myno = illn.illnessid;
		NSInteger illid = [myno integerValue];	
		
		NSMutableArray *erlist = [[NSMutableArray alloc] init];
		
		// Setup the SQL Statement and compile it for faster access
		NSString *temp = [[NSString alloc]initWithFormat:@"select cd.calldoc from calldoc cd,illness i,illness_calldoc ic where cd.ci_id=ic.ci_id and i.i_id=ic.i_id and i.i_id = '%d'",illid];
		
		const char *sqlStatement = [temp UTF8String];
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
		{
			// Loop through the results and add them to the array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{
				// Read the data from the result row
				NSString *er = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				
				[erlist addObject:er];
				
			}
			
			
		}
		sqlite3_finalize(compiledStatement);
		
		[temp release];
		
		cell.textLabel.text =[erlist objectAtIndex:indexPath.row];
		cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		cell.imageView.image = [UIImage imageNamed:@"Phonered.jpg"]; 
		
		
		[erlist release];
		return cell;
		
	}
	else if(indexPath.section == 2)
	{
		NSNumber *myno = illn.illnessid;
		NSInteger illid = [myno integerValue];	
		
		NSMutableArray *erlist = [[NSMutableArray alloc] init];
		
		// Setup the SQL Statement and compile it for faster access
		NSString *temp = [[NSString alloc]initWithFormat:@"select co.consultdoc from consultdoc co,illness i,illness_consultdoc ico where co.co_id=ico.co_id and i.i_id=ico.i_id and i.i_id = '%d'",illid];
		
		const char *sqlStatement = [temp UTF8String];
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
		{
			// Loop through the results and add them to the array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{
				// Read the data from the result row
				NSString *er = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				
				[erlist addObject:er];
				
			}
			
			
		}
		sqlite3_finalize(compiledStatement);
		
		[temp release];
		
		cell.textLabel.text =[erlist objectAtIndex:indexPath.row];
		cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		cell.imageView.image = [UIImage imageNamed:@"Phoneorange.png"]; 
		
		
		[erlist release];
		return cell;
	}
	else {
		cell.textLabel.text =@"Read care instructions";
		cell.imageView.image = [UIImage imageNamed:@"Home1.jpg"]; 
		
		return cell;
	}
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	if(indexPath.section == 0)
	{
		/*erViewController = [[EmergencyViewController alloc]initWithNibName:@"EmergencyViewController" bundle:nil];
		 [self.navigationController pushViewController:erViewController animated:YES];
		 [self.tableView reloadData];
		 [erViewController release];*/
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call" message:@"Call 911?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
		
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 40, 40)];
		
		NSString *path = [[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Phonered.png"]];
		UIImage *bkgImg = [[UIImage alloc] initWithContentsOfFile:path];
		[imageView setImage:bkgImg];
		[bkgImg release];
		[path release];
		
		[alert addSubview:imageView];
		[imageView release];
		
		[alert show];
		[alert release];
		
		
		
	}
	
	if(indexPath.section == 1)
	{
		/*calldrViewController = [[CallDoctorViewController alloc]initWithNibName:@"CallDoctorViewController" bundle:nil];
		 [self.navigationController pushViewController:calldrViewController animated:YES];
		 [self.tableView reloadData];
		 [calldrViewController release];*/
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CallEmergency" message:@"Call your child's doctor?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 40, 40)];
		
		NSString *path = [[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Phonered.png"]];
		UIImage *bkgImg = [[UIImage alloc] initWithContentsOfFile:path];
		[imageView setImage:bkgImg];
		[bkgImg release];
		[path release];
		
		[alert addSubview:imageView];
		[imageView release];
		
		[alert show];
		[alert release];
	}
	
	if(indexPath.section == 2)
	{
		/*calldrViewController = [[CallDoctorViewController alloc]initWithNibName:@"CallDoctorViewController" bundle:nil];
		 [self.navigationController pushViewController:calldrViewController animated:YES];
		 [self.tableView reloadData];
		 [calldrViewController release];*/
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CallDoctor" message:@"Call your child's doctor?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 40, 40)];
		
		NSString *path = [[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Phoneorange.png"]];
		UIImage *bkgImg = [[UIImage alloc] initWithContentsOfFile:path];
		[imageView setImage:bkgImg];
		[bkgImg release];
		[path release];
		
		[alert addSubview:imageView];
		[imageView release];
		
		[alert show];
		[alert release];
	}
	
	
	
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{	// the user clicked one of the OK/Cancel buttons
	NSString *title = [alertView title];
	
    if([title isEqualToString:@"Call"])
    {
		if (buttonIndex == 0)
		{
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:565"]];
			NSLog(@"called 911");
		}
	}
	if([title isEqualToString:@"CallEmergency"])
    {
		if (buttonIndex == 0)
		{
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:565"]];
			NSLog(@"called ER");
		}
	}
	if([title isEqualToString:@"CallDoctor"])
    {
		if (buttonIndex == 0)
		{
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:565"]];
			NSLog(@"called ER");
		}
	}
	
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
