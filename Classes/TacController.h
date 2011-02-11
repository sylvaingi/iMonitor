//
//  TacController.h
//  iMonitor
//
//  Created by Robert Zboub on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TacOverviewController.h"
#import "TacListController.h"

@interface TacController : UIViewController {
	TacListController *tacList;
	TacOverviewController *tacOverview;
}

@end
