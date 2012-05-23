//
//  WelcomePageViewController.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WelcomePageViewController.h"
#import "ASIHTTPRequest.h"





@implementation WelcomePageViewController
@synthesize svc,hvc,dvc,mvc,avc,umv;

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
	self.title=@"DoctorPro";
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	
}

- (NSString*) getUserDocumentsDirectoryByUrl:(NSString*) strUrl {
	
    
	
    NSArray *chunks = [strUrl componentsSeparatedByString: @"/"];
	
    NSString* fileName = [chunks lastObject];
	
    
	
    NSString* dwnldPath = [ [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] 
						   
                           stringByAppendingPathComponent:fileName];    
	
    
	NSLog(@"%@",dwnldPath);
    return dwnldPath;
	
}

- (NSString*) getUserDocumentsDirectoryByName:(NSString*) fileName {
	
	NSString* dwnldPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
						   stringByAppendingPathComponent:fileName];    
	
	return dwnldPath;
}

-(void)requestFinished:(ASIHTTPRequest *)request

{
	
	[[[[UIAlertView alloc] initWithTitle:@"Message" 
								 message:@"Your update is successful!" 
								delegate:self 
					   cancelButtonTitle:@"OK" 
					   otherButtonTitles:nil] autorelease] show];
}

-(void)requestFailed:(ASIHTTPRequest *)request {
	
	NSLog(@"%@",request.error);
}



- (IBAction)enterApp:(id)sender{
	
	svc = [[SymptomsViewController alloc]initWithNibName:@"SymptomsViewController" bundle:nil];	    
    [self.navigationController pushViewController:svc animated:YES];
    [svc release];
	
}
- (IBAction)enterHotLine:(id)sender{
	hvc = [[HotLineViewController alloc]initWithNibName:@"HotLineViewController" bundle:nil];
    [self.navigationController pushViewController:hvc animated:YES];
    [hvc release];
	
}

- (IBAction)enterDoctors:(id)sender{
	dvc = [[SpecialityViewController alloc]initWithNibName:@"SpecialityViewController" bundle:nil];
    [self.navigationController pushViewController:dvc animated:YES];
    [dvc release];
	
}

- (IBAction)enterLocation:(id)sender{
	mvc = [[MapController alloc]initWithNibName:@"MapController" bundle:nil];
    [self.navigationController pushViewController:mvc animated:YES];
    [mvc release];
	
}
- (IBAction)appointment:(id)sender{
	avc = [[AppointmentViewController alloc]initWithNibName:@"AppointmentViewController" bundle:nil];
    [self.navigationController pushViewController:avc animated:YES];
    [avc release];
}

- (IBAction)UserMapView:(id)sender
{
	
	
	umv = [[UserMapView alloc]initWithNibName:@"UserMapView" bundle:nil];
    [self.navigationController pushViewController:umv animated:YES];
    [umv release];
}

- (IBAction)grabURL:(id)sender
{
	
	NSURL *url = [NSURL URLWithString:@"https://dl.dropbox.com/s/6zl3n4gqwdpq05u/SymDB.sql?dl=1"];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDownloadDestinationPath:@"/Users/maheshkarthikduraisamy/Desktop/TEST/SymDB.sql"];
	[request setDownloadDestinationPath:[self getUserDocumentsDirectoryByName:@"SymDB.sql"]];
	[request setDelegate:self];
	[request startAsynchronous];	
}
//

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
