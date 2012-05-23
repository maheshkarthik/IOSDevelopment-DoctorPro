//
//  SymptomDetailViewController.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SymptomDetailViewController.h"
#import "Symptoms.h"
#import "SegmentViewController.h"
#import "FinalProjectAppDelegate.h"

NSMutableArray *array;
@implementation SymptomDetailViewController
@synthesize bodyPart, symptomArray,irow;

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
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	
	
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.title =@"Disease List";
	
	//FinalProjectAppDelegate* delegate = (FinalProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	//delegate.databaseAccess;


	
	databaseName = @"SymDB.sql";
	
//	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	self.symptomArray=[self symptomsForBodyPart:self.bodyPart];
	
	//[self.tableView reloadData];
	//self.tableView.scrollEnabled = YES;
	
	//NSLog(@"count",self.symptomArray);
}

- (NSMutableArray*) symptomsForBodyPart:(NSString*) bodyPart {

 // NSArray* array = [NSArray arrayWithObjects:@"symptom1", @"symptoms2", @"symptoms3", nil];
//	return array;
//}
	
	
	array = [[NSMutableArray alloc] init];
	// Open the database from the users filessytem
if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		
		//NSString *temp = [[NSString alloc]initWithFormat:@"select * from illness"];
	NSString *temp = [[NSString alloc]initWithFormat:@"select * from illness i,bodyindex b, bodyindex_illness bi where b.bi_id=bi.bi_id and i.i_id=bi.i_id and b.body = '%@'",self.bodyPart];
	const char *sqlStatement = [temp UTF8String];


		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				//NSLog(@"inside");
				NSNumber *illid = [NSNumber numberWithInt:sqlite3_column_int(compiledStatement, 0)];
				NSString *illness = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *definition = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *symptoms = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				
				[array addObject:[Symptoms illnessWithid:illid illness:illness defn:definition symp:symptoms]];
				
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	 
		return array;
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.symptomArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	//if(indexPath.section == 0)
	//{
	
	Symptoms *s= [array objectAtIndex:indexPath.row];
	//cell.textLabel.text=[self.symptomArray objectAtIndex:[indexPath row]];
	cell.textLabel.text=s.illness;
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	irow = [indexPath row];
	
	/*
	 If the requesting table view is the search display controller's table view, configure the next view controller using the filtered content, otherwise use the main list.
	 */
	Symptoms *i = nil;
	
	i = [array objectAtIndex:indexPath.row];
    
	
	SegmentViewController * svc = [[SegmentViewController alloc] initWithIllness:(Symptoms *)i num:(NSInteger)irow];
	
	
	[self.navigationController pushViewController:svc animated:YES];
    //[self.navigationController pushViewController:detailcontroller animated:YES];
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
	[symptomArray release];
	[bodyPart release];
    [super dealloc];
}




@end
