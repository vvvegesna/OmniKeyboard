//
//  KeyboardTableViewController.h
//  Omni Keyboard
//
//  Created by Sky on 10/9/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "changeKeyboard.h"

@interface KeyboardSelectorTableViewController : UITableViewController

@property (weak) id <changeKeyboard> delegate;
- (IBAction)buttonDone:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonDone;

@end
