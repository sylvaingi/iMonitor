//
//  TacOverviewController.h
//  iMonitor
//
//  Created by Sylvain Gizard on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TacOverviewController : UIViewController {
	//Hosts
	UIProgressView* hostProgress;
	UILabel* hostStatusUp;
	UILabel* hostStatusDown;
	UILabel* hostStatusUnreachable;
	UILabel* hostStatusPending;
	
	//Services
	UIProgressView* serviceProgress;
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

-(void) refreshWithData:(NSArray*)nagiosData;

@end
