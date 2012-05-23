//
//  HealthRecordController.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HealthRecordController.h"

#import "GoogleHealth.h"
#import "HealthVault.h"
#import "FinalProjectAppDelegate.h"
#import "MyProfileViewController.h"

@implementation HealthRecordController

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


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section==0)
		return 1;
	
	else if(section==1)
		return 1;
	
	
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	
	if(section == 0)
		return @"Microsoft HeathVault";
	else if(section == 1)
		return @"Google Health Users";
			
	
	
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	if(indexPath.section==0)
	{
		cell.textLabel.text=@"Health Vault";
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	}
	else if(indexPath.section==1)
	{
		cell.textLabel.text=@"Google Health";
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;	
	}
		return cell;
	
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if(indexPath.section==0)
	{
		HealthVault *hv=[[HealthVault alloc] initWithNibName:@"HealthVault" bundle:nil];
		[self.navigationController pushViewController:hv animated:YES];
		[self.tableView reloadData];
		[hv release];
	}
	
	else if(indexPath.section==1)
	{
		GoogleHealth *gh=[[GoogleHealth alloc] initWithNibName:@"GoogleHealth" bundle:nil];
		[self.navigationController pushViewController:gh animated:YES];
		[self.tableView reloadData];
		[gh release];
				
					
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
