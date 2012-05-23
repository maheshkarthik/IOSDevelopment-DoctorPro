//
//  iAdDemoViewController.h
//  iAdDemo
//
//  Created by Uppal'z on 29/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>


@interface iAdDemoViewController : UIViewController <ADBannerViewDelegate>{
    UIView *contentView;
    UITableView *myTableView;
    NSMutableArray *data;
    ADBannerView *adBannerView;
}

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) ADBannerView *adBannerView;

@end
