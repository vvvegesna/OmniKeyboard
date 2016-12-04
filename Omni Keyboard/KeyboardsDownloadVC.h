//
//  KeyboardsDownloadVC.h
//  Omni Keyboard
//
//  Created by Vijay Varma on 11/25/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "changeKeyboard.h"

@interface KeyboardsDownloadVC : UITableViewController
@property (weak) id <changeKeyboard> delegate;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Indicator;
- (IBAction)buttonDone:(id)sender;

@end
