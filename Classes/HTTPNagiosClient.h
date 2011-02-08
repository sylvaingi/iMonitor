//
//  HTTPNagiosClient.h
//  iMonitor
//
//  Created by Robert Zboub on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTTPNagiosClient : NSObject {
	NSMutableData *receivedData;
	id delegate;
	SEL successAction;
}


- (void)sendRequest:(NSString*)command delegate:(id)obj action:(SEL)successCallback;

@end
