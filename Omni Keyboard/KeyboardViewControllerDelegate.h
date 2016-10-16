//
//  KeyboardViewControllerDelegate.h
//  Omni Keyboard
//
//  Created by Sky on 10/16/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, ActionType)
{
    ActionTypeTouchDown,
    ActionTypeLiftUp
};

@protocol KeyboardViewControllerDelegate <NSObject>

-(void)keyActivated:(int)index action:(ActionType)action;

@end
