//
//  MyProfileHomePage.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyInsuranceController.h"
#import <iAd/iAd.h>


@interface MyProfileHomePage: UITableViewController<ADBannerViewDelegate> {
	
	MyInsuranceController *myic;
	
	UITableView *tv;
	ADBannerView *bannerView;
}

@property (nonatomic, retain) IBOutlet UITableView *tv;
@property (nonatomic, retain) ADBannerView *bannerView;
@property (nonatomic, retain) MyInsuranceController *myic;


- (void)Logout:(id)sender;


@end
