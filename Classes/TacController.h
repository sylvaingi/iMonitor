//
//  TacController.h
//  iMonitor
//
//  Created by Robert Zboub on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TacController : UIViewController {
	//Hosts
	UIButton* hostAccessButton;
	UIProgressView* hostProgress;
	UILabel* hostStatusUp;
	UILabel* hostStatusDown;
	UILabel* hostStatusUnreachable;
	UILabel* hostStatusPending;
	
	//Services
	UIButton* serviceAccessButton;
	UILabel* serviceStatusOk;
	UILabel* serviceStatusCritical;
	UILabel* serviceStatusWarning;
	UILabel* serviceStatusUnknown;
}

@property(nonatomic,retain) IBOutlet UIProgressView* hostProgress;
@property(nonatomic,retain) IBOutlet UILabel* hostStatusUp;
@property(nonatomic,retain) IBOutlet UILabel* hostStatusDown;
@property(nonatomic,retain) IBOutlet UILabel* hostStatusUnreachable;
@property(nonatomic,retain) IBOutlet UILabel* hostStatusPending;

- (IBAction)showHosts:(id)sender;

@end
