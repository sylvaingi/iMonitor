//
//  HotesController.m
//  iMonitor
//
//  Created by Robert Zboub on 29/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HotesController.h"
#import "HTTPNagiosClient.h"
#import "HoteDetailsController.h"

@implementation HotesController

@synthesize hotes;

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Hotes";
		self.hotes = [[NSArray alloc] init];
    }
    return self;
}



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	[self refreshHostStatus];
	
 	UIBarButtonItem *refreshButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
																					target:self 
																					action:@selector(refreshHostStatus)] autorelease];									  
	self.navigationItem.rightBarButtonItem = refreshButton;
}


- (void)refreshHostStatus{
	HTTPNagiosClient* client = [[HTTPNagiosClient alloc] init];
	
	[client sendRequest:@"cmd=2" delegate:self];
	
	[client release];
}

-(void) didReceiveNagiosData:(NSArray*)responseData{
	self.hotes = responseData;
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
    return [hotes count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary* hote = [hotes objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [hote objectForKey:@"host_name"];
	cell.detailTextLabel.text = [hote objectForKey:@"plugin_output"];
    
	UIImage* statusIcon;
	if([[hote objectForKey:@"current_state"] isEqualToString:@"0"])
		statusIcon = [UIImage imageNamed:@"check.png"];
	else {
		statusIcon = [UIImage imageNamed:@"cross.png"];
	}
	cell.imageView.image = statusIcon;

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
	NSString* host = [[self.hotes objectAtIndex:indexPath.row] objectForKey:@"host_name"] ;
	HoteDetailsController* controller = [[[HoteDetailsController alloc] initWithStyle:UITableViewStyleGrouped hostName:host] autorelease];
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
	[hotes release];
}


@end

