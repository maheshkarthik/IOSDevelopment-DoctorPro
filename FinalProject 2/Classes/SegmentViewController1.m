

#import "SegmentViewController1.h"
#import "DetailsViewController.h"
#import <MessageUI/MessageUI.h>
#import "FinalProjectAppDelegate.h"
#import "MyProfileViewController.h"
#import "UserDisease.h"




@implementation SegmentViewController1
@synthesize rowid,illness,segment,table,erlist,immlist,button;

NSMutableArray *imglist;
@synthesize diagnosisController;
@synthesize imageController;
@synthesize selguideline,selsymptom,selcare,userdiseaselist;

@synthesize session = _session;
@synthesize postGradesButton = _postGradesButton;
@synthesize logoutButton = _logoutButton;
@synthesize loginDialog = _loginDialog;
@synthesize facebookName = _facebookName;
@synthesize posting = _posting;



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
	NSString *str = illness.illness;
	self.title =str;
	
	// Get the path to the documents directory and append the databaseName
	databaseName = @"SymDB.sql";
	
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	
	[self readuserdiseasesFromDatabase];
	
	
	if(sqlite3_open([databasePath UTF8String], &database) != SQLITE_OK) {
		NSAssert1(0, @"Error: failed to open db with message '%s'.", sqlite3_errmsg(database));
	}
	static NSString* kApiKey = @"8fa673a06891cac667e55d690e27ecbb";
	static NSString* kApiSecret = @"325a4c580253c7619313baad5712cc2a";
	//	
	//static NSString* kApiKey = @"256397844456143";
	//static NSString* kApiSecret = @"047368d15675c7f5e3ab548eb244b186";
	
	_session = [[FBSession sessionForApplication:kApiKey secret:kApiSecret delegate:self] retain];
	
	// Load a previous session from disk if available.  Note this will call session:didLogin if a valid session exists.
	[_session resume];
	
	
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


- (void)addEvent:(id)sender {
	
	FinalProjectAppDelegate* delegate = (FinalProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	if(delegate.isLoggedIn)
	{
		//MyProfileViewController* mVC = [[MyProfileViewController alloc]initWithNibName:@"MyProfileViewController" bundle:nil];
		//		[self.navigationController pushViewController:mVC animated:YES];
		//		[mVC release];
		int flag = 0;
		for (UserDisease *ud in userdiseaselist) 
		{
			if([ud.diseasename isEqualToString:self.title]){
				if(ud.user_id == delegate.userID)
					flag = 1;
			}
			
		}
		if(flag==0)
		{
			
			NSString *temp = [[NSString alloc]initWithFormat:@"insert into user_saveddiseases values('%@','%@')",delegate.userID,self.title];
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
					[userdiseaselist addObject:[UserDisease userdiseaseWithuser_id:delegate.userID diseasename:self.title]];
					
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Disease bookmarked successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
					[alert show];
					[alert release];
					//[self.View reloadData];
				}	
				
			}
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Disease already bookmarked!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		
		
	}	
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Login to bookmark diseases!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
	
}

-(void) readuserdiseasesFromDatabase {
	// Setup the database object
	
	// Init the animals Array
	userdiseaselist = [[NSMutableArray alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from user_saveddiseases";
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



- (IBAction)postGradesTapped:(id)sender {
	_posting = YES;
	// If we're not logged in, log in first...
	if (![_session isConnected]) {
		self.loginDialog = nil;
		_loginDialog = [[FBLoginDialog alloc] init];	
		[_loginDialog show];	
	}
	// If we have a session and a name, post to the wall!
	else if (_facebookName != nil) {
		[self postToWall];
	}
	// Otherwise, we don't have a name yet, just wait for that to come through.
}

- (IBAction)logoutButtonTapped:(id)sender {
	[_session logout];
}


#pragma mark FBSessionDelegate methods

- (void)session:(FBSession*)session didLogin:(FBUID)uid {
	[self getFacebookName];
}

- (void)session:(FBSession*)session willLogout:(FBUID)uid {
	_logoutButton.hidden = YES;
	_facebookName = nil;
}

#pragma mark Get Facebook Name Helper

- (void)getFacebookName {
	NSString* fql = [NSString stringWithFormat:
					 @"select uid,name from user where uid == %lld", _session.uid];
	NSDictionary* params = [NSDictionary dictionaryWithObject:fql forKey:@"query"];
	[[FBRequest requestWithDelegate:self] call:@"facebook.fql.query" params:params];
}

#pragma mark FBRequestDelegate methods

- (void)request:(FBRequest*)request didLoad:(id)result {
	if ([request.method isEqualToString:@"facebook.fql.query"]) {
		NSArray* users = result;
		NSDictionary* user = [users objectAtIndex:0];
		NSString* name = [user objectForKey:@"name"];
		self.facebookName = name;		
		_logoutButton.hidden = NO;
		[_logoutButton setTitle:[NSString stringWithFormat:@"Facebook: Logout as %@", name] forState:UIControlStateNormal];
		if (_posting) {
			[self postToWall];
			_posting = NO;
		}
	}
}

#pragma mark Post to Wall Helper

- (void)postToWall {
	
	FBStreamDialog* dialog = [[[FBStreamDialog alloc] init] autorelease];
	dialog.userMessagePrompt = @"Enter your message:";
	
	NSMutableString *ill=[[NSMutableString alloc]init];
	[ill appendString:@"Guideline: "];
	[ill appendString: illness.illness];
	[ill appendString:@"\n"];
	[ill appendString:@" Symptom: "];
	[ill appendString: illness.symptoms];
	[ill appendString:@"\n"];
	[ill appendString:@" Care: "];
	[ill appendString: self.selcare];
	
	dialog.attachment = [NSString stringWithFormat:@"{\"caption\":\"DiseaseName\",\"description\":'%@',\"media\":[{\"type\":\"image\",\"src\":\"http://img40.yfrog.com/img40/5914/iphoneconnectbtn.jpg\",\"href\":\"http://developers.facebook.com/connect.php?tab=iphone/\"}],\"properties\":{\"another link\":{\"text\":\"Facebook home page\",\"href\":\"http://www.facebook.com\"}}}",illness.illness];
	[dialog show];
	
}




/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
-(id)initWithIllness:(Symptoms *)ill num:(NSInteger)row{
	
	self = [super init];
	if(self)
	{
		self.illness = ill;
		self.rowid = row;
		NSString *t = illness.illness;
		self.selguideline = [NSMutableString stringWithString:t];
		self.selsymptom = [NSMutableString stringWithString:@"None"];
		self.selcare = [NSMutableString stringWithString:@"None"];
        
		
	}
	
	return self;
}


-(IBAction)change
{
	if(segment.selectedSegmentIndex == 0)
	{
		self.table.scrollEnabled = YES;
		[self.table reloadData];
		
	}
	if(segment.selectedSegmentIndex == 1)
	{
		self.table.scrollEnabled = YES;
		[self.table reloadData];		
	}
	if(segment.selectedSegmentIndex == 2)
	{
		self.table.scrollEnabled = YES;
		[self.table reloadData];
		
	}
	
	
	
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	if(segment.selectedSegmentIndex == 0)
	{
		
		return 2;
	}
	else if(segment.selectedSegmentIndex == 1)
	{
		
		return 2;
	}
	else if(segment.selectedSegmentIndex == 2)
	{
	    return 5;
	}
	
	
}






- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	
	if(segment.selectedSegmentIndex == 0)
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
	
	
	
	else if(segment.selectedSegmentIndex == 1)
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
			
			headerLabel.text = @"Care at home"; // i.e. array element
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
			
			headerLabel.text = @"Over-the-counter medicines"; // i.e. array element
			[customView addSubview:headerLabel];
			
			return customView;
		}
	}
	else{
		
		if(section == 0){
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
			
			headerLabel.text = @"Selected Disease"; // i.e. array element
			[customView addSubview:headerLabel];
			
			return customView;
		}
		else if(section == 1){
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
			
			headerLabel.text = @"Symptoms Associated"; // i.e. array element
			[customView addSubview:headerLabel];
			
			return customView;
			
			
		}
		else if(section == 2){
			
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
			
			headerLabel.text = @"Recommendation"; // i.e. array element
			[customView addSubview:headerLabel];
			
			return customView;
			
		}
		else{
			
			// create the parent view that will hold header Label
			UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
			
			// create the button object
			UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			/*		headerLabel.backgroundColor = [UIColor lightGrayColor];
			 headerLabel.opaque = NO;
			 headerLabel.textColor = [UIColor blackColor];
			 headerLabel.highlightedTextColor = [UIColor whiteColor];
			 headerLabel.font = [UIFont boldSystemFontOfSize:20];
			 headerLabel.frame = CGRectMake(0.0, 0.0, 400.0, 22.0);
			 
			 // If you want to align the header text as centered
			 // headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
			 
			 headerLabel.text = @"Send Email"; // i.e. array element*/
			[customView addSubview:headerLabel];
			
			return customView;	
			
			
		}
		
		
	}
	
	
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if(segment.selectedSegmentIndex == 0)
	{
		
		if(section == 0)
			return @"Definition";
		else
			return @"Images";
	}
	
	else if(segment.selectedSegmentIndex == 1) {
		
		if(section == 0)
			return @"Care at home";
		else
			return @"Over-the-counter medicines";
	}
	else{
		if(section == 0)
			return @"Selected Guideline";
		else if(section == 1)
			return @"Symptom";
		else if(section == 2)
			return @"Suggestion";
		else {
			return @"";
		}
		
		
	}
	
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	if(segment.selectedSegmentIndex == 0)
	{
		
		if(indexPath.section == 0)
		{
			NSString *cellText = illness.definition;
			UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
			CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
			CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
			return labelSize.height + 20;
		}
		else 
		{
			return 40;
		}
	}
	
	else if(segment.selectedSegmentIndex == 1){
		if(indexPath.section == 0)
		{
			return 60;
		}
		else 
		{
			return 40;
		}
	}
	else{
		
		if(indexPath.section == 0)
		{
			return 40;
		}
		else if(indexPath.section == 1)
		{
			NSString *cellText = illness.symptoms;
			UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
			CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
			CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
			return labelSize.height + 20;
		}
		else if(indexPath.section == 2){
			return 120;
		}
		else
			return 120;
	}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	table = tableView;
	[self.button removeFromSuperview];
	
	
	UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	if(segment.selectedSegmentIndex == 0)
	{
		
		if(indexPath.section == 0)
		{
			table.separatorStyle = UITableViewCellSeparatorStyleSingleLine ;	
			NSString *def = illness.definition;
			cell.textLabel.text = def;
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
			cell.textLabel.numberOfLines = 0;
			cell.imageView.image = nil; 
			
			return cell;
			
		}
		else if(indexPath.section == 1)
		{
			
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
			table.separatorStyle = UITableViewCellSeparatorStyleSingleLine ;
			cell.textLabel.text =[imglist objectAtIndex:indexPath.row];
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
			cell.textLabel.numberOfLines = 0;
			cell.imageView.image = nil; 
			
			
			return cell;
			
		}
	}
    
	
	
	
	else if(segment.selectedSegmentIndex == 1){
		
		if(indexPath.section == 0)
		{
			
			NSNumber *myno = illness.illnessid;
			NSInteger illid = [myno integerValue];	
			
			NSMutableArray *falist = [[NSMutableArray alloc] init];
			// Setup the SQL Statement and compile it for faster access
			NSString *temp = [[NSString alloc]initWithFormat:@"select fa.firstaid from firstaid fa,illness i,illness_firstaid ifa where fa.fa_id=ifa.fa_id and i.i_id=ifa.i_id and i.i_id = '%d'",illid];
			const char *sqlStatement = [temp UTF8String];
			sqlite3_stmt *compiledStatement;
			if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
			{
				// Loop through the results and add them to the array
				while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
				{
					// Read the data from the result row
					NSString *fa = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
					
					[falist addObject:fa];
					
				}
				
				
			}
			sqlite3_finalize(compiledStatement);
			
			[temp release];
			
			NSString *firstaid = [falist objectAtIndex:indexPath.row];
			
			NSMutableString * bulletList = [NSMutableString stringWithCapacity:150];
			
			[bulletList appendFormat:@"\u2022 %@\n", firstaid];
			table.separatorStyle = UITableViewCellSeparatorStyleNone;
			cell.textLabel.text = bulletList;
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
			cell.imageView.image = nil; 
			
			[falist release];
			return cell;
			
			
		}
		
		else 
		{
			NSNumber *myno = illness.illnessid;
			NSInteger illid = [myno integerValue];	
			
			NSMutableArray *mlist = [[NSMutableArray alloc] init];
			
			// Setup the SQL Statement and compile it for faster access
			NSString *temp = [[NSString alloc]initWithFormat:@"select m.medicine from medicine m,illness i,illness_medicine im where m.m_id=im.m_id and i.i_id=im.i_id and i.i_id = '%d'",illid];
			
			const char *sqlStatement = [temp UTF8String];
			sqlite3_stmt *compiledStatement;
			if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
			{
				// Loop through the results and add them to the array
				while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
				{
					// Read the data from the result row
					NSString *m = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
					
					[mlist addObject:m];
					
				}
				
				
			}
			sqlite3_finalize(compiledStatement);
			
			[temp release];
			table.separatorStyle = UITableViewCellSeparatorStyleSingleLine ;
			cell.textLabel.text =[mlist objectAtIndex:indexPath.row];
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
			cell.imageView.image = nil; 
			
			
			[mlist release];
			return cell;
			
		}
		
	}
	else{
		
		if(indexPath.section == 0)
		{
			cell.textLabel.text = selguideline;
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
			cell.imageView.image = nil; 
			return cell;
		}
		else if(indexPath.section == 1)
		{
			table.separatorStyle = UITableViewCellSeparatorStyleSingleLine ;	
			NSString *def = illness.symptoms;
			cell.textLabel.text = def;
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
			cell.textLabel.numberOfLines = 0;
			cell.imageView.image = nil; 
			
			return cell;
		}
		else if(indexPath.section == 2)
			
		{
			cell.textLabel.text = selcare;
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
			cell.imageView.image = nil; 
			UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			[button addTarget:self action:@selector(postGradesTapped:)
			 forControlEvents:UIControlEventTouchDown];
			//set the position of the button
			button.frame = CGRectMake(10.0, 40.0, 300.0, 40.0);
			
			//set the button's title
			[button setTitle:@"Connect to Facebook" forState:UIControlStateNormal];
			
			//add the button to the view
			[cell.contentView addSubview:button];
			
			
			return cell;
		}
		else if(indexPath.section == 3)
			
		{
			cell.textLabel.text = selcare;
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
			cell.imageView.image = nil; 
			UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			[button addTarget:self action:@selector(logoutButtonTapped:)
			 forControlEvents:UIControlEventTouchDown];
			//set the position of the button
			button.frame = CGRectMake(10.0, 40.0, 300.0, 40.0);
			
			//set the button's title
			[button setTitle:@"Logout of Facebook" forState:UIControlStateNormal];
			
			//add the button to the view
			[cell.contentView addSubview:button];
			
			
			return cell;
		}
		
		else {
			
			cell.textLabel.text = @"";
			cell.imageView.image = nil; 
			
			//	self.button = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
			self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			[self.button addTarget:self 
							action:@selector(aMethod:)
				  forControlEvents:UIControlEventTouchDown];
			self.button.backgroundColor = [UIColor lightGrayColor];
			[self.button setTitle:@"Email Summary With Care Instruction" forState:UIControlStateNormal];
			self.button.frame = CGRectMake(10.0, 40.0, 300.0, 40.0);
			
			[cell.contentView addSubview:[self button]];
			//  [self.button release];
			
			return cell;
		}
	}
	
}

-(void)aMethod:(id)sender{
	
	
	MFMailComposeViewController *composer = [[MFMailComposeViewController alloc]init];
	composer.mailComposeDelegate = self;
	
	
	if([MFMailComposeViewController canSendMail])
	{
		NSMutableString *ill=[[NSMutableString alloc]init];
		[ill appendString:@"Guideline: "];
		[ill appendString: illness.illness];
		[ill appendString:@"\n"];
		[ill appendString:@" Symptom: "];
		[ill appendString: illness.symptoms];
		[ill appendString:@"\n"];
		[ill appendString:@" Care: "];
		[ill appendString: self.selcare];
		[composer setToRecipients:[NSArray arrayWithObjects:@"mahesh.karthikd@gmail.com",nil]];
		[composer setMessageBody:ill isHTML:NO];
		[self presentModalViewController:composer animated:YES];
	}
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
	
	[self dismissModalViewControllerAnimated:YES];
	
	if(result == MFMailComposeResultFailed)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"failed" message:@"Email failed to send" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	rowid = [indexPath row];
	NSLog(@"The row value is '%d'",rowid); 
	
	
	if(segment.selectedSegmentIndex == 0)
	{
		
		if(indexPath.section == 0)
		{
			
			segment.selectedSegmentIndex = 1;
			
			[self.table reloadData];
			
		}
		
		else
		{
			imageController = [[ImageViewController alloc]initWithNibName:@"ImageViewController" bundle:nil num:(NSInteger)rowid];
			[self.navigationController pushViewController:imageController animated:YES];
			[self.table reloadData];
			[imageController release];
		}
		
	}
	
	else{
	}
	
	
	
}




// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	
	if(segment.selectedSegmentIndex == 0)
	{
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
	
	
	
	else if(segment.selectedSegmentIndex == 1){
		if(section == 0)
		{
			
			NSNumber *myno = illness.illnessid;
			NSInteger illid = [myno integerValue];	
			
			NSMutableArray *falist = [[NSMutableArray alloc] init];
			
			// Setup the SQL Statement and compile it for faster access
			NSString *temp = [[NSString alloc]initWithFormat:@"select fa.firstaid from firstaid fa,illness i,illness_firstaid ifa where fa.fa_id=ifa.fa_id and i.i_id=ifa.i_id and i.i_id = '%d'",illid];
			const char *sqlStatement = [temp UTF8String];
			sqlite3_stmt *compiledStatement;
			if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
			{
				// Loop through the results and add them to the array
				while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
				{
					// Read the data from the result row
					NSString *fa = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
					
					[falist addObject:fa];
					
				}
				
				
			}
			sqlite3_finalize(compiledStatement);
			
			[temp release];
			
			return[falist count];
			
			[falist release];
			
			
		}
		
		else 
		{
			NSNumber *myno = illness.illnessid;
			NSInteger illid = [myno integerValue];	
			
			NSMutableArray *mlist = [[NSMutableArray alloc] init];
			
			// Setup the SQL Statement and compile it for faster access
			NSString *temp = [[NSString alloc]initWithFormat:@"select m.medicine from medicine m,illness i,illness_medicine im where m.m_id=im.m_id and i.i_id=im.i_id and i.i_id = '%d'",illid];
			
			const char *sqlStatement = [temp UTF8String];
			sqlite3_stmt *compiledStatement;
			if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
			{
				// Loop through the results and add them to the array
				while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
				{
					// Read the data from the result row
					NSString *m = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
					
					[mlist addObject:m];
					
				}
				
				
			}
			sqlite3_finalize(compiledStatement);
			
			[temp release];
			
		    return [mlist count];
			[mlist release];
			
		}
		
	}
	else{
		
		return 1;
		
	}
	
}





- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.postGradesButton = nil;
    self.logoutButton = nil;
	[self.erlist release];
	[self.immlist release];
	;
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[_session release];
	_session = nil;
	[_postGradesButton release];
	_postGradesButton = nil;
    [_logoutButton release];
	_logoutButton = nil;
    [_loginDialog release];
	_loginDialog = nil;
    [_facebookName release];
	_facebookName = nil;
    [super dealloc];
}


@end
