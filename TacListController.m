//
//  TacListController.m
//  iMonitor
//
//  Created by Sylvain Gizard on 09/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TacListController.h"
#import "NagiosStatus.h"

@implementation TacListController

@synthesize hostsStatus;
@synthesize servicesStatus;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return NO;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return [hostsStatus count];
		case 1:
			return [servicesStatus count];
	}
	return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	switch (indexPath.section) {
		case 0:{
			NSDictionary* host = [hostsStatus objectAtIndex:indexPath.row];
			cell.textLabel.text=[NSString stringWithFormat:@"Hôte - %@", [host objectForKey:@"host_name"]];
			cell.detailTextLabel.text = [host objectForKey:@"plugin_output"];
			break;
		}
		case 1:{
			NSDictionary* service = [servicesStatus objectAtIndex:indexPath.row];
			cell.textLabel.text=[NSString stringWithFormat:@"Service - %@ @ %@", [service objectForKey:@"service_description"], [service objectForKey:@"host_name"]];
			cell.detailTextLabel.text = [service objectForKey:@"plugin_output"];
			break;
		}
	}
    
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
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) refreshWithHostData:(NagiosStatus*)nagiosData {
	//Keep only down hosts
	self.hostsStatus = [nagiosData.resultsByStatus objectForKey:[NSNumber numberWithInt:HOST_DOWN]];
	[UIApplication sharedApplication].applicationIconBadgeNumber = [hostsStatus count] + [servicesStatus count];
	[self.tableView reloadData];
}

-(void) refreshWithServiceData:(NagiosStatus*)nagiosData {
	//Concatenate the warning and critical statuses array
	NSMutableArray *servicesProblems = [[NSMutableArray alloc] init];
	
	NSArray* statusCriticalServices = [nagiosData.resultsByStatus objectForKey:[NSNumber numberWithInt:SERVICE_CRITICAL]];
	if (statusCriticalServices != nil) {
		[servicesProblems addObjectsFromArray:statusCriticalServices];
	}
	
	NSArray* statusWarningServices = [nagiosData.resultsByStatus objectForKey:[NSNumber numberWithInt:SERVICE_WARNING]];
	if (statusWarningServices != nil) {
		[servicesProblems addObjectsFromArray:statusWarningServices];
	}

	self.servicesStatus = servicesProblems;
	[UIApplication sharedApplication].applicationIconBadgeNumber = [hostsStatus count] + [servicesStatus count];
	[self.tableView reloadData];
}

- (void)dealloc {
    [super dealloc];
}


@end

