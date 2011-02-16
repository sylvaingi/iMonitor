//
//  HostsStatus.m
//  iMonitor
//
//  Created by Sylvain Gizard on 15/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NagiosStatus.h"

int const HOST_UP = 0;
int const HOST_DOWN = 1;
int const SERVICE_UP = 0;
int const SERVICE_WARNING = 1;
int const SERVICE_CRITICAL = 2;
int const SERVICE_PENDING = 3;

@implementation NagiosStatus

@synthesize resultsByStatus;
@synthesize results;

- (id) initWithNagiosData:(NSArray*)nagiosResults{
	self = [super init];
	self.results = nagiosResults;
	
	NSMutableDictionary* sortByStatus = [[NSMutableDictionary alloc] init];
	
	for (NSDictionary* entity in results) {
		
		NSNumber* currentState = [NSNumber numberWithInt:[[entity objectForKey:@"current_state"] intValue]];
		NSMutableArray* statusArray = [sortByStatus objectForKey:currentState];
		
		if (statusArray==nil) {
			statusArray = [[NSMutableArray alloc]init];
			[sortByStatus setObject:statusArray forKey:currentState];
		}
		
		resultsByStatus = sortByStatus;
		
		[statusArray addObject:entity];
	
	}
	
	return self;
}


	

- (void)dealloc {
    [super dealloc];
	[results release];
	[resultsByStatus release];
}



@end
