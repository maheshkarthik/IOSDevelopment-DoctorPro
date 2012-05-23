#import <UIKit/UIKit.h>
#import "Symptoms.h"
#import "DiagnosisViewController.h"
#import "ImageViewController.h"
#import <MessageUI/MessageUI.h>
#import "FBConnect.h"




@interface SegmentViewController1 : UIViewController <MFMailComposeViewControllerDelegate,FBSessionDelegate, FBRequestDelegate> {
	
	FBSession* _session;
	FBLoginDialog *_loginDialog;
	UIButton *_postGradesButton;
	UIButton *_logoutButton;
	NSString *_facebookName;
	BOOL _posting;
	
	
	IBOutlet UISegmentedControl *segment;
	Symptoms *illness;
	NSInteger rowid;
	IBOutlet UITableView *table;
	
	NSString *databaseName;
	NSString *databasePath;
	sqlite3 *database;
	DiagnosisViewController *diagnosisController;
	ImageViewController *imageController;
	
	NSMutableString *selguideline;
	NSMutableString *selsymptom;
    NSMutableString *selcare;	
	
	NSMutableArray *erlist;
	NSMutableArray *immlist;
	NSMutableArray *doclist;
	NSMutableArray	*userdiseaselist;
	
	UIButton *button;
	
	
}

@property(nonatomic, retain) NSMutableArray *erlist;
@property(nonatomic, retain) NSMutableArray *immlist;
@property(nonatomic, retain) NSMutableArray *doclist;
@property(nonatomic, retain) NSMutableArray *userdiseaselist;
@property(nonatomic, retain) UIButton *button;

@property (nonatomic, retain) NSMutableString *selguideline;
@property (nonatomic, retain) NSMutableString *selsymptom;
@property (nonatomic, retain) NSMutableString *selcare;	
@property (nonatomic, retain) ImageViewController *imageController;
@property (nonatomic, retain) DiagnosisViewController *diagnosisController;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segment;
@property (nonatomic,retain) IBOutlet UITableView *table;
@property (nonatomic,retain) Symptoms *illness;
@property (nonatomic)NSInteger rowid;

@property (nonatomic, retain) FBSession *session;
@property (nonatomic, retain) IBOutlet UIButton *postGradesButton;
@property (nonatomic, retain) IBOutlet UIButton *logoutButton;
@property (nonatomic, retain) FBLoginDialog *loginDialog;
@property (nonatomic, copy) NSString *facebookName;
@property (nonatomic, assign) BOOL posting;

- (IBAction)postGradesTapped:(id)sender;
- (IBAction)logoutButtonTapped:(id)sender;
- (void)postToWall;
- (void)getFacebookName;



-(IBAction)change;
-(void) readuserdiseasesFromDatabase;

-(id)initWithIllness:(Symptoms *)ill num:(NSInteger)row;
- (IBAction) addEvent:(id)sender;
- (IBAction) Logout:(id)sender;

@end
