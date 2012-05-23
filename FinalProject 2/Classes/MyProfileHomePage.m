//
//  MyProfileHomePage.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MyProfileHomePage.h"
#import "MyInsuranceController.h"
#import "HealthRecordController.h"
#import "AppointmentViewController.h"
#import "FinalProjectAppDelegate.h"
#import "MyProfileViewController.h"
#import "LogoutController.h"
#import "UserDiseasesViewController.h"


@interface MyProfileHomePage (privatemethods)
- (void)createBannerView;
- (void)showBanner;
- (void)hideBanner;
- (void)releaseBanner;
- (void)changeBannerOrientation:(UIInterfaceOrientation)toOrientation;

@end

@implementation MyProfileHomePage
@synthesize myic;
@synthesize tv, bannerView;

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
	//self.view.backgroundColor = [UIColor yellowColor];
	
	[super viewDidLoad];
	[self createBannerView];    
    NSIndexPath *indexPath = [self.tv indexPathForSelectedRow];
	
	if (indexPath) {
		[self.tv deselectRowAtIndexPath:indexPath animated:YES];
	}
	
	if (bannerView) {
		UIInterfaceOrientation orientation = self.interfaceOrientation;
		[self changeBannerOrientation:orientation];
	}
	
	    
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
	
[self hideBanner];  
	
}

- (void)Logout:(id)sender{

	
	FinalProjectAppDelegate* delegate = (FinalProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	delegate.isLoggedIn=false;
	delegate.userID=0;
	MyProfileViewController* mVC = [[MyProfileViewController alloc]initWithNibName:@"MyProfileViewController" bundle:nil];
    [self.navigationController pushViewController:mVC animated:YES];
    [mVC release];	
}
	

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
								duration:(NSTimeInterval)duration {
	
	if (bannerView) {
		[self changeBannerOrientation:toInterfaceOrientation];
	}
}



- (void)createBannerView {
	
	Class cls = NSClassFromString(@"ADBannerView");
	if (cls) {
		ADBannerView *adView = [[cls alloc] initWithFrame:CGRectZero];
		adView.requiredContentSizeIdentifiers = [NSSet setWithObjects:ADBannerContentSizeIdentifier320x50,
												 ADBannerContentSizeIdentifier480x32, nil];
		
		// Set the current size based on device orientation
		adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
		adView.delegate = self;
		
		adView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
		
		// Set intital frame to be offscreen
		CGRect bannerFrame =adView.frame;
		bannerFrame.origin.y = - bannerFrame.size.height;
		adView.frame = bannerFrame;
		
		self.bannerView = adView;
		
		[self.view addSubview:adView];
		[adView release];
	}
}

- (void)showBanner {
	
	CGFloat fullViewHeight = self.view.frame.size.height;
	CGRect tableFrame = self.tv.frame;
	CGRect bannerFrame = self.bannerView.frame;
	
	// Shrink the tableview to create space for banner
    tableFrame.size.height = fullViewHeight - bannerFrame.size.height;
	tableFrame.origin.y = bannerFrame.size.height;
	
	// Move banner onscreen
	bannerFrame.origin.y = 0; 
	
	[UIView beginAnimations:@"showBanner" context:NULL];
	self.tv.frame = tableFrame;
	self.bannerView.frame = bannerFrame;
	[UIView commitAnimations];
}

- (void)hideBanner {
	
	// Grow the tableview to occupy space left by banner
	CGFloat fullViewHeight = self.view.frame.size.height;
	CGRect tableFrame = self.tv.frame;
    tableFrame.size.height = fullViewHeight;
	tableFrame.origin.y = 0;
	
	// Move the banner view offscreen
	CGRect bannerFrame = self.bannerView.frame;
	bannerFrame.origin.y = - bannerFrame.size.height;
	
	self.tv.frame = tableFrame;
	self.bannerView.frame = bannerFrame;
}

- (void)releaseBanner {
	
	if (self.bannerView) {
		bannerView.delegate = nil;
		self.bannerView = nil;
	}
}

- (void)changeBannerOrientation:(UIInterfaceOrientation)toOrientation {
	
	if (UIInterfaceOrientationIsLandscape(toOrientation)) {
		self.bannerView.currentContentSizeIdentifier = 
		ADBannerContentSizeIdentifier480x32;
	}
	else {
		self.bannerView.currentContentSizeIdentifier = 
		ADBannerContentSizeIdentifier320x50;
	}
}

#pragma mark -
#pragma mark === ADBannerViewDelegate Methods ===
#pragma mark -

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
	
	[self showBanner];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
	
	[self hideBanner];
}
#pragma mark -
#pragma mark === Reachability Notification ===
#pragma mark -




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section==0)
		return 1;
	
	else if(section==1)
		return 1;
	else {
		return 1;
	}

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	

		if(section == 0)
			return @"My Insurance";
		else if(section == 1)
			return @"My Health Record";
	else
			return @"Saved Info";		

	
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	if(indexPath.section==0)
	{
		cell.textLabel.text=@"My Insurance";
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	}
	else if(indexPath.section==1)
	{
	 if(indexPath.row==0)
	 {
		 cell.textLabel.text=@"My Health Record";
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	 }
		
	}
	else if(indexPath.section==2)
	{
		if(indexPath.row==0)
		{
			cell.textLabel.text=@"Saved Diseases";
			cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
		}
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
	MyInsuranceController *mic=[[MyInsuranceController alloc] initWithNibName:@"MyInsuranceController" bundle:nil];
	[self.navigationController pushViewController:mic animated:YES];
	//[self.tableView reloadData];
    [mic release];	
	}
	
	else if(indexPath.section==1)
	{
		if(indexPath.row==0)
		{

			HealthRecordController *hrc=[[HealthRecordController alloc] initWithNibName:@"HealthRecordController" bundle:nil];
			[self.navigationController pushViewController:hrc animated:YES];
			//[self.tableView reloadData];
			[hrc release];	
		}
	
	
   }
	else if(indexPath.section==2)
	{
		if(indexPath.row==0)
		{
			
			UserDiseasesViewController *hrc=[[UserDiseasesViewController alloc] initWithNibName:@"UserDiseasesViewController" bundle:nil];
			[self.navigationController pushViewController:hrc animated:YES];
			//[self.tableView reloadData];
			[hrc release];	
		}
}

}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[self releaseBanner];
    [super viewDidUnload];
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[self releaseBanner];	
	    [super dealloc];
}




@end
