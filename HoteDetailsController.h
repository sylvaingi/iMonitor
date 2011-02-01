//
//  HoteDetailsController.h
//  iMonitor
//
//  Created by Robert Zboub on 29/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HoteDetailsController : UITableViewController {
	NSString* hostName;
	NSDictionary* hostDetails;
}

@property(nonatomic,retain)NSString* hostName;
@property(nonatomic,retain)NSDictionary* hostDetails;

- (id)initWithStyle:(UITableViewStyle)style hostName:(NSString*)name;

@end
