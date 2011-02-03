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
	NSLog(@"Sending request to Nagios API");
	
	delegate = obj;
	
	//Create the request and show the network indicator
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:
							  [NSURL URLWithString:[@"http://134.214.221.144/inag.php?key=key&" stringByAppendingString:command]]];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	if (theConnection) {
		receivedData = [[NSMutableData data] retain];
	} else {
		NSLog(@"Creating the request failed");
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	//Reset received data on redirect
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [connection release];
    [receivedData release];
	
	//TODO: notification on error
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	//Process the response with the differents separators
	NSString *response = [[NSString alloc]initWithData:receivedData encoding:NSISOLatin1StringEncoding];
	
	//Top level: components (hosts/services) : '-###-' separator
	NSMutableArray *components =[[response componentsSeparatedByString:@"-###-"] mutableCopy];
	NSMutableArray *processedComponents =[NSMutableArray array];
	
	//Remove last component, always blank
	if([components count] !=1)
		[components removeObjectAtIndex:[components count] -1];
	
	for (int i=0; i<[components count]; i++) {
		NSArray *lines=[[components objectAtIndex:i] componentsSeparatedByString:@"\n"];
		NSMutableDictionary *dico = [[NSMutableDictionary alloc]initWithCapacity:10];
	
		//Second level, key values separated by '<,>'
		for (int j=0; j<[lines count]-1; j++) {
			NSArray *tokens=[[lines objectAtIndex:j] componentsSeparatedByString:@"<,>"];
			[dico setValue:[tokens objectAtIndex:1] forKey:[tokens objectAtIndex:0]];
		}
		
		[processedComponents addObject:dico];
	}
	
	NSLog(@"Received response :\n %@",processedComponents);
	
	//Send the success message to the delegate
	[delegate didReceiveNagiosData:processedComponents];
	
	//Cleanup
	[response release];
    [connection release];
    [receivedData release];
}

@end
