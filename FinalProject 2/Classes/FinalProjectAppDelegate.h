//
//  FinalProjectAppDelegate.h
//  FinalProject
//
//  Created by Mahesh Karthik Duraisamy on 4/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface FinalProjectAppDelegate  : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	
	NSString *databaseName;
	NSString *databasePath;
	sqlite3 *database;
}
@property (nonatomic, assign) BOOL isLoggedIn;
@property (nonatomic, assign) NSNumber *userID;
@property (nonatomic,retain) NSString *databaseName;
@property (nonatomic,retain) NSString *databasePath;


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

-(void) checkAndCreateDatabase;
-(void) databaseAccess;


@end


