    //
//  TacOverviewController.m
//  iMonitor
//
//  Created by Sylvain Gizard on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TacOverviewController.h"


@implementation TacOverviewController

@synthesize hostProgress;
@synthesize hostStatusUp;
@synthesize hostStatusDown;
@synthesize hostStatusUnreachable;
@synthesize hostStatusPending;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return NO;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) refreshWithData:(NSArray*)nagiosData {
	int up = 0;
	int down = 0;
	int unreach = 0;
	int pending = 0;
	
	for (NSDictionary* host in nagiosData) {
		switch ([[host objectForKey:@"current_state"] intValue]) {
			case 0:
				up++;
				break;
			case 1:
				down++;
				break;
			case 2:
				unreach++;
				break;
			case 3:
				pending++;
				break;
			default:
				break;
		} 
	}
	
	self.hostStatusUp.text = [NSString stringWithFormat:@"Ok:%d",up];
	self.hostStatusDown.text = [NSString stringWithFormat:@"Down:%d",down];
	self.hostStatusUnreachable.text = [NSString stringWithFormat:@"Unreachable:%d",unreach];
	self.hostStatusPending.text = [NSString stringWithFormat:@"Pending\n%d",pending];
	self.hostProgress.progress = ((float)up)/[nagiosData count];
}

- (void)dealloc {
    [super dealloc];
}


@end
