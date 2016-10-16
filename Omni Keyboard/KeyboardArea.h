//
//  KeyboardKey.h
//  Omni Keyboard
//
//  Created by Sky on 10/16/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewControllerDelegate.h"

@interface KeyboardArea : UIView
{
    id _delegate;
    int _index;
}

@property id <KeyboardViewControllerDelegate> delegate;
@property int index;

@end
