//
//  HotLineViewController.m
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HotLineViewController.h"
#include <netdb.h>
#import <SystemConfiguration/SystemConfiguration.h>


@implementation HotLineViewController
@synthesize tempArray;

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
	self.title =@"HotLines";
	
	tempArray = nil;
    [tempArray addObject:@"Call 911"];
	[tempArray addObject:@"Police(non-emergency) 311"];	
	[tempArray addObject:@"Poison Control 1(800) 222-1222"];
	[tempArray addObject:@"Suicide Hotline 1(800) 273-8255"];
	[tempArray addObject:@"Domestic Abuse 1(800) 799-7233"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	
	if(section == 0)
	{
		return @"Emergency";
	}
	else 
	{
		return @"National Hotlines";
	}
	
	
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if(section == 0)
	{
		return 1;
	}
	else if(section==1)
	{
		return 4;
	}

	return 0;
    
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	if(indexPath.section == 0)
	{
		
			cell.textLabel.text = @"Call 911";
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
			cell.imageView.image = [UIImage imageNamed:@"911.jpg"]; 	
			return cell;
			
		
		
	}
	else if(indexPath.section ==1)
	{
		
		if(indexPath.row == 0)
		{
			cell.textLabel.text = @"Police(non-emergency) 311";
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
			cell.imageView.image = [UIImage imageNamed:@"police.jpg"]; 		
			return cell;
			
		}
		else if(indexPath.row == 1)	
		{
			cell.textLabel.text = @"Poison Control 1(800) 222-1222";
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
			cell.imageView.image = [UIImage imageNamed:@"poison-1.png"]; 	
			return cell;
			
		}
		else if(indexPath.row == 2)	
		{
			cell.textLabel.text = @"Suicide Hotline 1(800) 273-8255";
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
			cell.imageView.image = [UIImage imageNamed:@"suicide.png"]; 	
			return cell;
			
		}
		else 
		{
			cell.textLabel.text = @"Domestic Abuse 1(800) 799-7233";
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
			cell.imageView.image = [UIImage imageNamed:@"domestic.jpg"]; 	
			return cell;
			
		}
	}
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(indexPath.section == 0)
	{
		if(indexPath.row == 0)
		{
			
			
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
		
		
	}
	if(indexPath.section == 1)
	{
		if(indexPath.row == 0)
		{
			
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call" message:@"Call Police(non-emergency)?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
			
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
		else if(indexPath.row == 1)
		{
			
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call" message:@"Call Poison Control?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
			
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
		else if(indexPath.row == 2)
		{
			
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call" message:@"Call Suicide Hotline?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
			
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
		else
		{
			
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call" message:@"Call Domestic Abuse?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
			
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
