//
//  HTTPNagiosClient.m
//  iMonitor
//
//  Created by Robert Zboub on 22/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HTTPNagiosClient.h"


@implementation HTTPNagiosClient

- (void)sendRequest:(NSString*)command delegate:(id)obj{
	
	delegate = obj;
	
	// Create the request.
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:[@"http://192.168.87.101/inag.php?key=key&" stringByAppendingString:command]]
											  cachePolicy:NSURLRequestUseProtocolCachePolicy
										  timeoutInterval:60.0];
	
	// create the connection with the request
	// and start loading the data
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	if (theConnection) {
		// Create the NSMutableData to hold the received data.
		// receivedData is an instance variable declared elsewhere.
		receivedData = [[NSMutableData data] retain];
	} else {
		// Inform the user that the connection failed.
		NSLog(@"Creating the request failed");
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
	
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
	
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection 
		didReceiveData:(NSData *)data {
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
		didFailWithError:(NSError *)error {
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
	
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	NSString *response = [[NSString alloc]initWithData:receivedData encoding:NSISOLatin1StringEncoding];
	
	NSMutableArray *components =[[response componentsSeparatedByString:@"-###-"] mutableCopy];
	NSMutableArray *processedComponents =[NSMutableArray array];
	
	if([components count] !=1)
		[components removeObjectAtIndex:[components count] -1];
	
	for (int i=0; i<[components count]; i++) {
		
		NSArray *lines=[[components objectAtIndex:i] componentsSeparatedByString:@"\n"];
		NSMutableDictionary *dico = [[NSMutableDictionary alloc]initWithCapacity:10];
	
		for (int j=0; j<[lines count]-1; j++) {
			NSArray *tokens=[[lines objectAtIndex:j] componentsSeparatedByString:@"<,>"];
			[dico setValue:[tokens objectAtIndex:1] forKey:[tokens objectAtIndex:0]];
		}
		
		[processedComponents addObject:dico];
	}
	
	NSLog(@"%@",processedComponents);
	
	[delegate didReceiveNagiosData:processedComponents];
	
	//cleanup
	[response release];
    [connection release];
    [receivedData release];
}

@end
