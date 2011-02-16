//
//  TacOverviewController.h
//  iMonitor
//
//  Created by Sylvain Gizard on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NagiosStatus.h"

@interface TacOverviewController : UIViewController {
	//Hosts
	UIProgressView* hostProgress;
	UILabel* hostStatusUp;
	UILabel* hostStatusDown;
	
	//Services
	UIProgressView* serviceProgress;
	UILabel* serviceStatusOk;
	UILabel* serviceStatusCritical;
	UILabel* serviceStatusWarning;
	UILabel* serviceStatusPending;
}

@property(nonatomic,retain) IBOutlet UIProgressView* hostProgress;
@property(nonatomic,retain) IBOutlet UILabel* hostStatusUp;
@property(nonatomic,retain) IBOutlet UILabel* hostStatusDown;

@property(nonatomic,retain) IBOutlet UIProgressView* serviceProgress;
@property(nonatomic,retain) IBOutlet UILabel* serviceStatusOk;
@property(nonatomic,retain) IBOutlet UILabel* serviceStatusCritical;
@property(nonatomic,retain) IBOutlet UILabel* serviceStatusWarning;
@property(nonatomic,retain) IBOutlet UILabel* serviceStatusPending;

-(void) refreshWithHostData:(NagiosStatus*)nagiosData;
-(void) refreshWithServiceData:(NagiosStatus*)nagiosData;

@end
