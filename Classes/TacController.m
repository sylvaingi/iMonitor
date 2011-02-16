    //
//  TacController.m
//  iMonitor
//
//  Created by Robert Zboub on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TacController.h"
#import "HTTPNagiosClient.h"
#import "NagiosStatus.h"


@implementation TacController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"Tactical status" image:[UIImage imageNamed:@"radar"] tag:0];
        self.title=@"Tactical status";
		
		tacOverview = [[[TacOverviewController alloc] initWithNibName:@"TacOverviewController" bundle:nil] retain];
		tacOverview.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 160);
		[self.view addSubview:tacOverview.view];
		
		tacList = [[[TacListController alloc] initWithStyle:UITableViewStylePlain] retain];
		tacList.view.frame = CGRectMake(0, 160, self.view.frame.size.width, self.view.frame.size.height-160);
		[self.view addSubview:tacList.view];
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
	HTTPNagiosClient* hostClient = [[HTTPNagiosClient alloc] init];
	[hostClient sendRequest:@"cmd=2" delegate:self action:@selector(didReceiveHostData:)];
	[hostClient release];
	
	HTTPNagiosClient* serviceClient = [[HTTPNagiosClient alloc] init];
	[serviceClient sendRequest:@"cmd=3" delegate:self action:@selector(didReceiveServiceData:)];
	[serviceClient release];
}

-(void) didReceiveHostData:(NagiosStatus*)nagiosData{
	[tacOverview refreshWithHostData : nagiosData];
	[tacList refreshWithHostData : nagiosData];
}

-(void) didReceiveServiceData:(NagiosStatus*)nagiosData{
	[tacOverview refreshWithServiceData : nagiosData];
	[tacList refreshWithServiceData : nagiosData];
}

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

- (void)dealloc {
    [super dealloc];
	[tacList release];
	[tacOverview release];
}


@end
