//
//  MyProfileViewController.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"RegistrationViewController.h"
#import <sqlite3.h>
#import "MyProfileHomePage.h"
#import <iAd/iAd.h>


@interface MyProfileViewController : UIViewController<UITextFieldDelegate,ADBannerViewDelegate> {

	IBOutlet UITextField *userName;
	IBOutlet UITextField *password;
	IBOutlet UIButton *loginbutton;
	IBOutlet UIActivityIndicatorView *indicator;
	RegistrationViewController *rvc;
	MyProfileHomePage *mphc;
	NSMutableArray *userlist;
	NSString *databaseName;
	NSString *databasePath;
	
	



}

@property (nonatomic, retain) UITextField *userName;
@property (nonatomic, retain) UITextField *password;
@property (nonatomic, retain) UIButton *loginbutton;
@property (nonatomic, retain) UIActivityIndicatorView *indicator;
@property (nonatomic, retain) RegistrationViewController *rvc;
@property (nonatomic, retain) MyProfileHomePage *mphc;
@property (nonatomic, retain) NSMutableArray *userlist;

@property (nonatomic, retain) ADBannerView *adBannerView;

- (void) createAdBannerView;
- (void) adjustBannerView;



- (IBAction) loginButton: (id) sender;
- (IBAction) regButton: (id) sender;
-(void) readUsersFromDatabase;

@end