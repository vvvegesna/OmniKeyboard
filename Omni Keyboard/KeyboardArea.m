//
//  KeyboardKey.m
//  Omni Keyboard
//
//  Created by Sky on 10/16/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import "KeyboardArea.h"

@implementation KeyboardArea

@synthesize delegate = _delegate;
@synthesize index = _index;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /* Check to see if the touch is within a key.
     * If so, tell the delegate which key and that it was a TouchDown.
     */
    
    [_delegate keyActivated:_index action:ActionTypeTouchDown];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /* Check to see if the lift is within a key.
     * If so, tell the delegate which key and that it was a LiftUp.
     */
    
    [_delegate keyActivated:_index action:ActionTypeLiftUp];
}

@end
