//
//  LoginScreenViewController.h
//  LoginScreen
//
//  Created by Chakra on 30/04/10.
//  Copyright Chakra Interactive Pvt Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginScreenViewController : UIViewController {
	
	IBOutlet UITextField *userName;
	IBOutlet UITextField *password;
	IBOutlet UIButton *loginbutton;
	IBOutlet UIActivityIndicatorView *indicator;
}

@property (nonatomic, retain) UITextField *userName;
@property (nonatomic, retain) UITextField *password;
@property (nonatomic, retain) UIButton *loginbutton;
@property (nonatomic, retain) UIActivityIndicatorView *indicator;

- (IBAction) loginButton: (id) sender;
@end

