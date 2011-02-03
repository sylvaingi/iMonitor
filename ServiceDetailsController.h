//
//  untitled.h
//  iMonitor
//
//  Created by Sylvain Gizard on 03/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ServiceDetailsController : UITableViewController {
	NSArray *servicesHotes;
}

@property(nonatomic,retain) NSArray *servicesHotes;

- (id)initWithStyle:(UITableViewStyle)style serviceHosts:(NSArray*)serviceHosts;

@end
