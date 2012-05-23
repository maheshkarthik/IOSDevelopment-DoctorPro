//
//  HealthVault.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HealthVault.h"
#import "FinalProjectAppDelegate.h"
#import "MyProfileViewController.h"

@implementation HealthVault

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSString *tempURLString = [[NSString alloc] initWithFormat:@"http://www.microsoft.com/en-us/healthvault/"];
	NSURL *myURL = [NSURL URLWithString:tempURLString];
	NSURLRequest *req1= [NSURLRequest requestWithURL:myURL]; 
	[webView loadRequest:req1];
	
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
