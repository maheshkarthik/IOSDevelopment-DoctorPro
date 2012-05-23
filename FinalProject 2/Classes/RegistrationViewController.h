//
//  RegistrationViewController.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface RegistrationViewController : UIViewController<UITextFieldDelegate> {
	
	UITextField *fnameview;
	UITextField *lnameview;
	UITextField *emailview;
	UITextField *usernameview;
	UITextField *passwordview;
	UITextField *sexview;
	
	NSString *databaseName;
	NSString *databasePath;
	sqlite3 *database;
}
	
	@property (nonatomic, retain) UITextField *fnameview;
	@property (nonatomic, retain) UITextField *lnameview;
	@property (nonatomic, retain) UITextField *emailview;
	@property (nonatomic, retain) UITextField *usernameview;
	@property (nonatomic, retain) UITextField *passwordview;

	@property (nonatomic, retain) UITextField *sexview;



@end
