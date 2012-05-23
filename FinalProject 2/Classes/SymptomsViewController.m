//
//  SymptomsViewController.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SymptomsViewController.h"
#import "SymptomDetailViewController.h"

@implementation SymptomsViewController

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

-(IBAction) bodyPartClickedHead :(id) sender 
{
	SymptomDetailViewController* sdvc = [[SymptomDetailViewController alloc] initWithNibName:@"SymptomDetailViewController" bundle:nil];	    
	sdvc.bodyPart = @"Head";
	[self.navigationController pushViewController:sdvc animated:YES];
	[sdvc release];
}
-(IBAction) bodyPartClickedHands :(id) sender 
{
	SymptomDetailViewController* sdvc = [[SymptomDetailViewController alloc] initWithNibName:@"SymptomDetailViewController" bundle:nil];	    
	sdvc.bodyPart = @"Hands";
	[self.navigationController pushViewController:sdvc animated:YES];
	[sdvc release];
}
-(IBAction) bodyPartClickedLegs :(id) sender 
{
	SymptomDetailViewController* sdvc = [[SymptomDetailViewController alloc] initWithNibName:@"SymptomDetailViewController" bundle:nil];	    
	sdvc.bodyPart = @"Legs";
	[self.navigationController pushViewController:sdvc animated:YES];
	[sdvc release];
}
-(IBAction) bodyPartClickedChest :(id) sender 
{
	SymptomDetailViewController* sdvc = [[SymptomDetailViewController alloc] initWithNibName:@"SymptomDetailViewController" bundle:nil];	    
	sdvc.bodyPart = @"Chest";
	[self.navigationController pushViewController:sdvc animated:YES];
	[sdvc release];
}
-(IBAction) bodyPartClickedAbdomen :(id) sender 
{
	SymptomDetailViewController* sdvc = [[SymptomDetailViewController alloc] initWithNibName:@"SymptomDetailViewController" bundle:nil];	    
	sdvc.bodyPart = @"Abdomen";
	[self.navigationController pushViewController:sdvc animated:YES];
	[sdvc release];
}

@end
