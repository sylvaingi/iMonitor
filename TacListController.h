//
//  TacListController.h
//  iMonitor
//
//  Created by Sylvain Gizard on 09/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HoteDetailsController.h"
#import "NagiosStatus.h"


@interface TacListController : UITableViewController{
	NSArray* hostsStatus;
	NSArray* servicesStatus;
}

@property(nonatomic,retain) NSArray* hostsStatus;
@property(nonatomic,retain) NSArray* servicesStatus;

-(void) refreshWithHostData:(NagiosStatus*)nagiosData;
-(void) refreshWithServiceData:(NagiosStatus*)nagiosData;

@end
