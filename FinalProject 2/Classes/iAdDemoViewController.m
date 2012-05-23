//
//  iAdDemoViewController.m
//  iAdDemo
//
//  Created by Uppal'z on 29/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "iAdDemoViewController.h"

@interface iAdDemoViewController(Private)
- (void) createDatasource;
- (void) createAdBannerView;
- (void) adjustBannerView;
@end

@implementation iAdDemoViewController
@synthesize contentView;
@synthesize myTableView;
@synthesize data;
@synthesize adBannerView;

#pragma mark - Private Methods
- (void) createDatasource
{
    data = [[NSMutableArray alloc] initWithObjects:@"Ford Mustang", @"Jaguar C-X16", @"Pagani Huayra", @"Bugatti Galibier", 
                                                    @"Aston Martin's", @"V12 Zagato", @"Alfa Romeo 4C", @"McLaren", @"Mercedes-Benz SL-Class", @"BMW X1", @"Ford Tuarus", @"Lamborghini Aventador", nil];
}

- (void) createAdBannerView
{
    adBannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    CGRect bannerFrame = self.adBannerView.frame;
    bannerFrame.origin.y = self.view.frame.size.height;
    self.adBannerView.frame = bannerFrame;
    
    self.adBannerView.delegate = self;
    self.adBannerView.requiredContentSizeIdentifiers = [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
}

- (void) adjustBannerView
{
    CGRect contentViewFrame = self.view.bounds;
    CGRect adBannerFrame = self.adBannerView.frame;
    
    if([self.adBannerView isBannerLoaded])
    {
        CGSize bannerSize = [ADBannerView sizeFromBannerContentSizeIdentifier:self.adBannerView.currentContentSizeIdentifier];
        contentViewFrame.size.height = contentViewFrame.size.height - bannerSize.height;
        adBannerFrame.origin.y = 100;
		adBannerFrame.origin.x = 100;
    }
    else
    {
		adBannerFrame.origin.y = 100;
		adBannerFrame.origin.x = 100;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.adBannerView.frame = adBannerFrame;
        self.contentView.frame = contentViewFrame;        
    }];
}

#pragma mark - ADBannerViewDelegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
	
    [self adjustBannerView];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self adjustBannerView];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    //TO DO
    //Check internet connecction here
    /*
    if(internetNotAvailable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet." message:@"Please make sure an internet connection is available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return NO;
    }*/
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    
}

#pragma mark - UITableViewDelegate & Datasource

- (NSUInteger) tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (NSUInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
    return 1;
}

-(UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"myIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier] autorelease];
    }
    
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:72.0/255.0 green:79.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createDatasource];
    
    [self createAdBannerView];    
    [self.view addSubview:self.adBannerView];    
}

- (void)viewDidUnload
{
    [self setContentView:nil];
    [self setMyTableView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation))
        self.adBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    else
        self.adBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    return YES;
}

- (void)dealloc {
    [contentView release];
    [myTableView release];
    
    [data release];
    data = nil;
    
    [adBannerView release];
    adBannerView = nil;
    [super dealloc];
}
@end
