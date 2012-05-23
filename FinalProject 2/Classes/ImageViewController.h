//
//  ImageViewController.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Symptoms.h"


@interface ImageViewController : UIViewController {
	
	NSInteger rowid;
	
	IBOutlet UIImageView *myImage;
	
	
}

@property (nonatomic, retain) UIImageView *myImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil num:(NSInteger)row;

@end
