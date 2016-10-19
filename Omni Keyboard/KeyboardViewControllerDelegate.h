//
//  KeyboardViewControllerDelegate.h
//  Omni Keyboard
//
//  Created by Sky on 10/16/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Define ActionType enum */
typedef NS_ENUM(NSUInteger, ActionType)
{
    ActionTypeTouchDown,
    ActionTypeLiftUp
};

@protocol KeyboardViewControllerDelegate <NSObject>

/**
 * KeyArea doesn't need to know everything about KeyboardViewController,
 * it just needs to be able to call this.
 */
-(void)keyUsed:(int)index type:(ActionType)type;

@end
