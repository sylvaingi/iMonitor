    //
//  TacOverviewController.m
//  iMonitor
//
//  Created by Sylvain Gizard on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TacOverviewController.h"
#import "NagiosStatus.h"


@implementation TacOverviewController

@synthesize hostProgress;
@synthesize hostStatusUp;
@synthesize hostStatusDown;

@synthesize serviceProgress;
@synthesize serviceStatusOk;
@synthesize serviceStatusCritical;
@synthesize serviceStatusWarning;
@synthesize serviceStatusPending;

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

-(void) refreshWithHostData:(NagiosStatus*)nagiosData {

	int up = [[nagiosData.resultsByStatus objectForKey:[NSNumber numberWithInt:HOST_UP]] count];
	int down = [[nagiosData.resultsByStatus objectForKey:[NSNumber numberWithInt:HOST_DOWN]] count];
	
	self.hostStatusUp.text = [NSString stringWithFormat:@"%d",up];
	self.hostStatusDown.text = [NSString stringWithFormat:@"%d",down];
	self.hostProgress.progress = ((float)up)/((float)(up+down));
}

-(void) refreshWithServiceData:(NagiosStatus*)nagiosData {
	
	int up = [[nagiosData.resultsByStatus objectForKey:[NSNumber numberWithInt:SERVICE_UP]] count];
	int pending = [[nagiosData.resultsByStatus objectForKey:[NSNumber numberWithInt:SERVICE_PENDING]] count];
	int warning = [[nagiosData.resultsByStatus objectForKey:[NSNumber numberWithInt:SERVICE_WARNING]] count];
	int critical = [[nagiosData.resultsByStatus objectForKey:[NSNumber numberWithInt:SERVICE_CRITICAL]] count];
	
	self.serviceStatusOk.text = [NSString stringWithFormat:@"%d",up];
	self.serviceStatusPending.text = [NSString stringWithFormat:@"%d",pending];
	self.serviceStatusWarning.text = [NSString stringWithFormat:@"%d",warning];
	self.serviceStatusCritical.text = [NSString stringWithFormat:@"%d",critical];
	
	self.serviceProgress.progress = ((float)up)/((float)(up+pending+warning+critical));
}

- (void)dealloc {
    [super dealloc];
}


@end
