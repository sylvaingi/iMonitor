//
//  HoteDetailsController.m
//  iMonitor
//
//  Created by Robert Zboub on 29/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HoteDetailsController.h"
#import "HTTPNagiosClient.h"


@implementation HoteDetailsController

@synthesize hostName;
@synthesize hostDetails;

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style hostName:(NSString*)name{
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        self.title = [NSString stringWithFormat:@"Details de %@",name];
		hostName = [name copy];
    }
    return self;
}


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	[self refreshHostDetails];
	
 	UIBarButtonItem *refreshButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
																					target:self 
																					action:@selector(refreshHostDetails)] autorelease];									  
	self.navigationItem.rightBarButtonItem = refreshButton;

}

-(void) refreshHostDetails{
	HTTPNagiosClient* client = [[HTTPNagiosClient alloc] init];
	
	[client sendRequest:[NSString stringWithFormat:@"cmd=5&host=%@",hostName] delegate:self];
	
	[client release];
}

-(void) didReceiveNagiosData:(NSArray*)responseData{
	self.hostDetails = [responseData objectAtIndex:0];
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
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
		case 0:
			return 3;
		case 1:
			return 4;
	}
	return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { 
	switch (section) {
		case 0:
			return @"Etat";
		case 1:
			return @"Planification";
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    if(hostDetails!=nil){
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease] ;
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];	
    switch (indexPath.section) {
		case 0:
			switch (indexPath.row) {
				case 0:
					cell.textLabel.text = @"Statut";
					int statusValue = [[self.hostDetails objectForKey:@"current_state"] intValue];
					NSString* detailText;
					UIColor* detailColor;
					if (statusValue==0) {
						detailText = @"up";
						detailColor = [UIColor greenColor];
					}
					else {
						detailText = @"down";
						detailColor = [UIColor redColor];
					}
					cell.detailTextLabel.text = detailText;
					cell.detailTextLabel.textColor = detailColor;
					break;
				case 1:
					cell.textLabel.text = @"Depuis";
					int timeStamp = [[self.hostDetails objectForKey:@"last_time_up"] intValue];
					if (timeStamp != 0) {
						NSDate* uptime = [NSDate dateWithTimeIntervalSince1970: timeStamp];
						cell.detailTextLabel.text = [dateFormatter stringFromDate:uptime];
					}
					else {
						cell.detailTextLabel.text = @"N/A";
					}
					break;
			}
			break;
		case 1:
			switch (indexPath.row) {
				case 0:
					cell.textLabel.text = @"Dernier test";
					NSDate* lastCheck = [NSDate dateWithTimeIntervalSince1970: [[self.hostDetails objectForKey:@"last_check"] intValue]];
					cell.detailTextLabel.text = [dateFormatter stringFromDate:lastCheck];
					break;
				case 1:
					cell.textLabel.text = @"Prochain test";
					NSDate* nextCheck = [NSDate dateWithTimeIntervalSince1970: [[self.hostDetails objectForKey:@"next_check"] intValue]];
					cell.detailTextLabel.text = [dateFormatter stringFromDate:nextCheck];
					break;
				case 2:
					cell.textLabel.text = @"Dernier changement";
					NSDate* lastChange = [NSDate dateWithTimeIntervalSince1970: [[self.hostDetails objectForKey:@"last_state_change"] intValue]];
					cell.detailTextLabel.text = [dateFormatter stringFromDate:lastChange];
					break;
				case 3:
					cell.textLabel.text = @"Prochain test";
					NSDate* aaaa = [NSDate dateWithTimeIntervalSince1970: [[self.hostDetails objectForKey:@"next_check"] intValue]];
					cell.detailTextLabel.text = [dateFormatter stringFromDate:aaaa];
					break;
			}
			
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
}


@end

