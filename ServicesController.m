//
//  ServicesController.m
//  iMonitor
//
//  Created by Robert Zboub on 29/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ServicesController.h"
#import "HTTPNagiosClient.h"
#import "ServiceDetailsController.h"

@implementation ServicesController

@synthesize services;
@synthesize servicesNames;

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Services";
		self.services = [NSDictionary dictionary];
		servicesNames = [[NSArray alloc]init];
    }
    return self;
}



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	[self refreshServices];
	
 	UIBarButtonItem *refreshButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
																					target:self 
																					action:@selector(refreshServices)] autorelease];									  
	self.navigationItem.rightBarButtonItem = refreshButton;
}

-(void) refreshServices {
	HTTPNagiosClient* client = [[HTTPNagiosClient alloc] init];
	
	[client sendRequest:@"cmd=3" delegate:self action:@selector(didReceiveNagiosData:)];
	
	[client release];
}

-(void) didReceiveNagiosData:(NSArray*)responseData{
	NSArray *servicesArray = responseData;
	NSMutableDictionary* actualServices = [[NSMutableDictionary alloc] init];
	for (NSDictionary* service in servicesArray) {
		NSLog(@"%@",service);
		
		NSString* serviceName = [service objectForKey:@"service_description"];
		
		NSMutableArray* serviceHosts= [actualServices objectForKey:serviceName];
		if (serviceHosts == nil ) {
			serviceHosts = [[NSMutableArray alloc] init];
			[actualServices setObject:serviceHosts forKey:serviceName];
		}
		[serviceHosts addObject:service];
	}
	self.services = actualServices;
	self.servicesNames =[services allKeys];
	[self.tableView reloadData];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [services count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	NSString* serviceName = [servicesNames objectAtIndex:indexPath.row];
	cell.textLabel.text = serviceName;
	
	//State counter
	int ok = 0;
	int warning = 0 ;
	int critical = 0;
	int unknown = 0;
	NSArray* serviceHosts = [services objectForKey:serviceName];
	for (NSDictionary* service in serviceHosts) {
		switch ([[service objectForKey:@"current_state"] intValue]) {
			case 0:
				ok++;
				break;
			case 1:
				warning++;
				break;
			case 2:
				critical++;
				break;
			case 3:
				unknown++;
				break;
			default:
				break;
		}
	}
	cell.detailTextLabel.text = [NSString stringWithFormat:@"Ok:%d  Warning:%d  Critical:%d Unknown:%d  Total:%d",ok,warning,critical,unknown,ok+warning+critical+unknown];
	
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSArray* serviceHosts = [self.services objectForKey:[self.servicesNames objectAtIndex:indexPath.row]];
	ServiceDetailsController* controller = [[[ServiceDetailsController alloc] initWithStyle:UITableViewStyleGrouped serviceHosts:serviceHosts] autorelease];
	[self.navigationController pushViewController:controller animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[services release];
}


@end

