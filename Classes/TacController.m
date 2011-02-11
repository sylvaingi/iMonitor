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

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"Tactical status" image:nil tag:0];
        self.title=@"Tactical status";
		
		tacOverview = [[[TacOverviewController alloc] initWithNibName:@"TacOverviewController" bundle:nil] retain];
		tacOverview.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 150);
		[self.view addSubview:tacOverview.view];
		
		tacList = [[[TacListController alloc] initWithStyle:UITableViewStylePlain] retain];
		tacList.view.frame = CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height-150);
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

-(void) didReceiveHostData:(NSArray*)responseData{
	
	/*NSMutableDictionary *hostStatus =[NSMutableDictionary dictionary];

	for (NSDictionary* host in nagiosData) {
		
		[hostStatus objectForKey:[host objectForKey:@"current_state"]];
		
		switch ([[host objectForKey:@"current_state"] intValue]) {
			case 0:
				
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
	
	[tacOverview refreshWithHostData : hostStatus];
	[tacList refreshWithHostData : hostStatus];*/
}
-(void) didReceiveServiceData:(NSArray*)responseData{
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
