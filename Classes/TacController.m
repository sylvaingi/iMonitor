    //
//  TacController.m
//  iMonitor
//
//  Created by Robert Zboub on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TacController.h"
#import "HTTPNagiosClient.h"


@implementation TacController


@synthesize hostProgress;
@synthesize hostStatusUp;
@synthesize hostStatusDown;
@synthesize hostStatusUnreachable;
@synthesize hostStatusPending;

- (void) setUpHostUpNumber:(int)nb{
	self.hostStatusUp.text = [NSString stringWithFormat:@"Ok:%d",nb];
}

- (void) setDownHostNumber:(int)nb{
	self.hostStatusDown.text = [NSString stringWithFormat:@"Down:%d",nb];
}

- (void) setUnreachableHostNumber:(int)nb{
	self.hostStatusUnreachable.text = [NSString stringWithFormat:@"Unreachable:%d",nb];
}

- (void) setPendingHostNumber:(int)nb{
	self.hostStatusPending.text = [NSString stringWithFormat:@"Pending\n%d",nb];
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"Tactical status" image:nil tag:0];
        self.title=@"Tactical status";
		
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self refreshTac];
	
 	UIBarButtonItem *refreshButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
																					target:self 
																					action:@selector(refreshTac)] autorelease];									  
	self.navigationItem.rightBarButtonItem = refreshButton;
}

- (void)refreshTac{
	HTTPNagiosClient* client = [[HTTPNagiosClient alloc] init];
	
	[client sendRequest:@"cmd=2" delegate:self action:@selector(didReceiveNagiosData)];
	
	[client release];
}

-(void) didReceiveNagiosData:(NSArray*)responseData{
	NSArray* hosts = responseData;
	int up = 0;
	int down = 0;
	int unreach = 0;
	int pending = 0;
	
	for (NSDictionary* host in hosts) {
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
	
	[self setUpHostUpNumber:up];
	[self setDownHostNumber:down];
	[self setUnreachableHostNumber:unreach];
	[self setPendingHostNumber:pending];
	
	self.hostProgress.progress = ((float)up)/[hosts count];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
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

-(IBAction)showHosts:(id)sender{
}

- (void)dealloc {
    [super dealloc];
}


@end
