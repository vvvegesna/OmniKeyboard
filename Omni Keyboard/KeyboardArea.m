//
//  KeyboardKey.m
//  Omni Keyboard
//
//  Created by Sky on 10/16/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import "KeyboardArea.h"

@implementation KeyboardArea

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches happened with index %i", self.tag);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches ended with index %i", self.tag);
}

@end
