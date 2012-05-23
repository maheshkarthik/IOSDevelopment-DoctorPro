//
//  LoginScreenViewController.m
//  LoginScreen
//
//  Created by Chakra on 30/04/10.
//  Copyright Chakra Interactive Pvt Ltd 2010. All rights reserved.
//

#import "LoginScreenViewController.h"

@implementation LoginScreenViewController

@synthesize userName,password,loginbutton,indicator;

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


- (IBAction) loginButton: (id) sender
{
	// TODO: spawn a login thread
	
	indicator.hidden = FALSE;
	[indicator startAnimating];
	
	loginbutton.enabled = FALSE;
}


@end
