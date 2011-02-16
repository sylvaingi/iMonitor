//
//  ServicesController.h
//  iMonitor
//
//  Created by Robert Zboub on 29/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDetailsController.h"


@interface ServicesController : UITableViewController {
	NSDictionary* services;
	NSArray* servicesNames;
}

@property(nonatomic,retain) NSDictionary* services;
@property(nonatomic,retain) NSArray* servicesNames;

@end
