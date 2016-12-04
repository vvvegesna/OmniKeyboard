//
//  ConfigTableViewController.h
//  Omni Keyboard
//
//  Created by Sky on 10/2/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "changeKeyboard.h"

@interface MenuTableViewController : UITableViewController

@property (nonatomic,retain) id <changeKeyboard> passDelegate;
- (IBAction)buttonDone:(id)sender;

@end
