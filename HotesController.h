//
//  HotesController.h
//  iMonitor
//
//  Created by Robert Zboub on 29/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HoteDetailsController.h"


@interface HotesController : UITableViewController {
	NSArray* hotes;
}

@property(nonatomic,retain) NSArray* hotes;

@end
