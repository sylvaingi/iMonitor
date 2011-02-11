//
//  TacListController.h
//  iMonitor
//
//  Created by Sylvain Gizard on 09/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TacListController : UITableViewController{

}

-(void) refreshWithData:(NSArray*)nagiosData;

@end
