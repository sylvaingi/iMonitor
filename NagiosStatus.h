//
//  HostsStatus.h
//  iMonitor
//
//  Created by Sylvain Gizard on 15/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


extern int const HOST_UP;
extern int const HOST_DOWN;
extern int const SERVICE_UP;
extern int const SERVICE_WARNING;
extern int const SERVICE_CRITICAL;
extern int const SERVICE_PENDING;

@interface NagiosStatus : NSObject {
	NSDictionary* resultsByStatus;
	NSArray* results;
}

@property(nonatomic,retain) NSDictionary *resultsByStatus;
@property(nonatomic,retain) NSArray* results;

- (id) initWithNagiosData:(NSArray*)results;

@end
