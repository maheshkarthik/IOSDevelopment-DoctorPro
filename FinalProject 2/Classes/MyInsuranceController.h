//
//  MyInsuranceController.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface MyInsuranceController : UIViewController<UITextFieldDelegate> {
	
	NSMutableArray	*userinsurancelist;;
	IBOutlet UILabel *insurancenamelabel;
	IBOutlet UILabel *planlabel;
	IBOutlet UITextField *insurancename;
	IBOutlet UITextField *plan;
	IBOutlet UIButton *addoreditbutton;
	
	NSString *databaseName;
	NSString *databasePath;
	sqlite3 *database;

	
}
	@property (nonatomic, retain) NSMutableArray *userinsurancelist;
	@property (nonatomic, retain) IBOutlet UILabel *insurancenamelabel;
	@property (nonatomic, retain) IBOutlet UILabel *planlabel;
	
	@property (nonatomic, retain) IBOutlet UITextField *insurancename;
	@property (nonatomic, retain) IBOutlet UITextField *plan;
	
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil initialText:(NSString *)txt ;

- (IBAction) addoreditButton: (id) sender;
-(void) readuserinsuranceFromDatabase;



@end
