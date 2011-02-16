//
//  ConfigController.m
//  iMonitor
//
//  Created by Sylvain Gizard on 14/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConfigController.h"


@implementation ConfigController


#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Configuration";
		self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"Configuration" image:[UIImage imageNamed:@"gear"] tag:0];
    }
    return self;
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
/*
	switch (indexPath.row) {
		case 0:
			cell.textLabel.text = @"Adresse IP";
			break;
		case 1:
			cell.textLabel.text = @"Port";
			break;
	}
*/
    CGRect frame =CGRectMake(5 ,10 , 320, 44);
	UITextField *textField = [[UITextField alloc]initWithFrame:frame];
	[textField setBorderStyle:UITextBorderStyleNone];
	textField.delegate=self;
	switch (indexPath.section) {
        case 0:
			textField.tag=0;
			textField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"serverAddress"];
			break;
        case 1:
			textField.tag=1;
			textField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"serverPort"];
			break;
        default:
			break;
	}
	[cell.contentView addSubview:textField];
	[textField release];
	cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { 
	switch (section) {
		case 0:
			return @"Adresse IP ou URL du serveur Nagios";
		case 1:
			return @"Port d'écoute du serveur Nagios";
		default:
			return @"Default";
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
	switch (textField.tag) {
		case 0:
			[[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"serverAddress"];
			NSLog([NSString stringWithFormat:@"IP changed to : %@",textField.text]);
			break;
		case 1:
			[[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"serverPort"];
			NSLog([NSString stringWithFormat:@"Port changed to : %@",textField.text]);
			break;
		default:
			break;
	}
	
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



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

