    //
//  DetailsViewController.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailsViewController.h"
#import "DiagnosisViewController.h"
#import "Symptoms.h"
#import "SymptomsViewController.h"
#import <sqlite3.h> // Import the SQLite database framework

NSMutableArray *imglist;


@implementation DetailsViewController
@synthesize illness;
@synthesize diagnosisController;
@synthesize imageController;
@synthesize row;


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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil illn:(Symptoms *)ill num:(NSInteger)xrow
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		self.illness=ill;
		self.row = xrow;
		
	}
	return self;
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title =@"Disease Details";
	
	// Get the path to the documents directory and append the databaseName
	databaseName = @"SymDB.sql";
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	if(sqlite3_open([databasePath UTF8String], &database) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to open db with message '%s'.", sqlite3_errmsg(database));
	}
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	//Number of rows it should expect should be based on the section
	/*NSDictionary *dictionary = [listOfItems objectAtIndex:section];
	 NSArray *array = [dictionary objectForKey:@"Countries"];
	 return [array count];*/
	if(section==0)
		return 1;
	else 
	{
		
		NSNumber *myno = illness.illnessid;
		NSInteger illid = [myno integerValue];	
		
		NSLog(@"the value of illnessid is '%d'",illid);
		
		//int illid = 1002;
		imglist = [[NSMutableArray alloc] init];
		
		// Setup the SQL Statement and compile it for faster access
		NSString *temp = [[NSString alloc]initWithFormat:@"select img.image from images img,illness i,illness_images ii where img.img_id=ii.img_id and i.i_id=ii.i_id and i.i_id = '%d'",illid];
		const char *sqlStatement = [temp UTF8String];
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
		{
			// Loop through the results and add them to the array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{
				// Read the data from the result row
				NSString *imgname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				
				[imglist addObject:imgname];
				
			}
			sqlite3_finalize(compiledStatement);
			
			
		}
		[temp release];
		return[imglist count];
		
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
		
		headerLabel.text = @"Definition"; // i.e. array element
		[customView addSubview:headerLabel];
		
		return customView;
	}
	
	else 
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
		
		headerLabel.text = @"Images"; // i.e. array element
		[customView addSubview:headerLabel];
		
		return customView;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if(section == 0)
		return @"Definition";
	else
		return @"Images";
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(indexPath.section == 0)
	{
		NSString *cellText = illness.definition;
		UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
		CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
		CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
		return labelSize.height + 20;
	}
	else {
		return 40;
	}
	
	
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	if(indexPath.section == 0)
	{
		NSString *def = illness.definition;
		cell.textLabel.text = def;
		cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
	}
	else {
		
		NSNumber *myno = illness.illnessid;
		NSInteger illid = [myno integerValue];
		
		
		
		//NSString *illid = [NSString stringWithFormat:@"%d",illness.illnessid];
		//int illid = 1002;
		NSMutableArray *imglist = [[NSMutableArray alloc] init];
		
		// Setup the SQL Statement and compile it for faster access
		NSString *temp = [[NSString alloc]initWithFormat:@"select img.image from images img,illness i,illness_images ii where img.img_id=ii.img_id and i.i_id=ii.i_id and i.i_id = '%d'",illid];
		
		NSLog(@"The value is..'%d'",illid); 
		const char *sqlStatement = [temp UTF8String];
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
		{
			// Loop through the results and add them to the array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{
				// Read the data from the result row
				NSString *imgname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				
				[imglist addObject:imgname];
				
			}
			sqlite3_finalize(compiledStatement);
			
		}
		else{
			NSAssert1(0,@"Error images '%s'",sqlite3_errmsg(database));
		}
		// Release the compiled statement from memory
		[temp release];
		
		cell.textLabel.text =[imglist objectAtIndex:indexPath.row];
		cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		
		
	}
	
    cell.textLabel.numberOfLines = 0;
	
	return cell;
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	row = [indexPath row];
	NSLog(@"The row value is '%d'",row); 
	
	/*
	 If the requesting table view is the search display controller's table view, configure the next view controller using the filtered content, otherwise use the main list.
	 */
	Symptoms *illnes = nil;
	
	
	if(indexPath.section == 0)
	{
		illnes = self.illness;
		diagnosisController = [[DiagnosisViewController alloc]initWithNibName:@"DiagnosisViewController" bundle:nil ill:(Symptoms *)illnes];
		[self.navigationController pushViewController:diagnosisController animated:YES];
		[self.tableView reloadData];
		[diagnosisController release];
		
	}
	
	if(indexPath.section == 1)
	{
		imageController = [[ImageViewController alloc]initWithNibName:@"ImageViewController" bundle:nil num:(NSInteger)row];
		[self.navigationController pushViewController:imageController animated:YES];
		[self.tableView reloadData];
		[imageController release];
	}
	
	
	
}




/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

-(void)viewWillDisappear:(BOOL)animated{
	
	/*	NSString *temp = [[NSString alloc]initWithFormat:@"insert into studs_table values('%@','%@','%@','%@','%@','%@')",firstname,lastname,city,simg,pno,email];
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
	 [listContent addObject:[Student studentWithFirstname:firstname lname:lastname city:city simg:@"sri.jpg" pnum:pno email:email]];
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Student added successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	 [alert show];
	 [alert release];
	 
	 
	 }
	 }*/		
	
	
	
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
