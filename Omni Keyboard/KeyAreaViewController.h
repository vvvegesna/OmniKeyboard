//
//  KeyboardArea.h
//  Omni Keyboard
//
//  Created by Sky on 10/17/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KeyboardViewControllerDelegate.h"

@interface KeyAreaViewController : UIViewController

@property id <KeyboardViewControllerDelegate> delegate;



-(void)newLayoutWithRows:(int)rows columns:(int)columns;

-(void)updateLayoutViewWithStrings:(NSArray*)strings;

@end
