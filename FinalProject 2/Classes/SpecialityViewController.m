//
//  SpecialityViewController.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SpecialityViewController.h"
#import "Speciality.h"
#import "NearestDocViewController.h"


@implementation SpecialityViewController
@synthesize savedSearchTerm, savedScopeButtonIndex, searchWasActive;
@synthesize row,specialityList,filteredListContent;


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
	
	self.title =@"Speciality List";
	self.tableView.dataSource = self;
	self.tableView.delegate = self;	
	
	databaseName = @"SymDB.sql";
	
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	
	// Query the database for all animal records and construct the "animals" array
	[self readSpecialityFromDatabase];
	
	[self.tableView reloadData];
	self.tableView.scrollEnabled = YES;
}

-(void) readSpecialityFromDatabase {
	// Setup the database object
	
	// Init the  Array
	
	specialityList = [[NSMutableArray alloc] init];
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from speciality";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSNumber *spid = [NSNumber numberWithInt:sqlite3_column_int(compiledStatement, 0)];
				NSString *sp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				
				
				[specialityList addObject:[Speciality initWithSpeciality:sp]];
				
			}
			// create a filtered list that will contain Employees for the search results table.
			self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.specialityList count]];
			
			// restore search settings if they were saved in didReceiveMemoryWarning.
			if (self.savedSearchTerm)
			{
				[self.searchDisplayController setActive:self.searchWasActive];
				[self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
				[self.searchDisplayController.searchBar setText:savedSearchTerm];
				
				self.savedSearchTerm = nil;
			}
			
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
    }
	else
	{
        return [self.specialityList count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
	}
	
	/*
	 If the requesting table view is the search display controller's table view, configure the cell using the filtered content, otherwise use the main list.
	 */
	Speciality *d = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        d = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else {
		
		d = [specialityList objectAtIndex:indexPath.row];
	}

    
	
	cell.textLabel.text = d.speciality;
	//cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
	
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	
	return cell;
}








- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	row = [indexPath row];
	
	Speciality *d = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        d = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
	d = [specialityList objectAtIndex:indexPath.row];
	
	}
	NearestDocViewController *ndc=[[NearestDocViewController alloc] initWithNibName:@"NearestDocViewController" bundle:nil];
	ndc.speciality=d.speciality;
    [self.navigationController pushViewController:ndc animated:YES];
    [ndc release];
	
	
}

- (void)viewDidDisappear:(BOOL)animated {
	self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
}



/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for Employees whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (Speciality *s in specialityList)
	{
		NSComparisonResult result = [s.speciality compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
		if (result == NSOrderedSame)
		{
			[self.filteredListContent addObject:s];
		}
		
	}
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}




- (void)viewDidUnload {
    [super viewDidUnload];
	self.filteredListContent = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[filteredListContent release];
    [super dealloc];
}


@end
