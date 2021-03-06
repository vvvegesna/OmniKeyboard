//
//  KeyboardArea.m
//  Omni Keyboard
//
//  Created by Sky on 10/17/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import "KeyAreaViewController.h"

@interface KeyAreaViewController ()
{
    int _rows;
    int _columns;
    NSMutableArray* _keys;
    
    id <KeyboardViewControllerDelegate> _delegate;
}

@end

@implementation KeyAreaViewController

@synthesize delegate = _delegate;

///** Set up the view. Can change keyboard background color here. */
-(KeyAreaViewController*)initWithFrame:(CGRect)frame
{
    self = [super init];
    if(self)
    {
        _keys = [[NSMutableArray alloc] init];
        UIView* view = [[UIView alloc] initWithFrame:frame];
        //[view setBackgroundColor:[UIColor whiteColor]];
        
        self.view = view;
    }
    
    return self;
}

/** Sets up a new layout with any number of rows and columns.
 * Reuses existing keys. Only makes new ones if it has to.
 * Deletes extra keys, if there are any.
 */
-(void)newLayoutWithRows:(int)rows columns:(int)columns
{    
    _rows = rows;
    _columns = columns;
    
    int usableWidth = self.view.bounds.size.width;
    int usableHeight = self.view.bounds.size.height;
    
    int widthPerButton = usableWidth/columns;
    int heightPerButton = usableHeight/rows;
    
    // Intentionally outside of any loop. Only set to 0 by the FIRST loop.
    int index;
    
    for(index = 0; index < MIN(rows*columns, _keys.count); ++index)
    {   // Reposition existing buttons
        UILabel* key = _keys[index];
        key.frame = CGRectMake( (index%columns)*widthPerButton,
                               (index/columns)*heightPerButton,
                               widthPerButton,
                               heightPerButton);
    }
    
    for(; index < rows*columns; ++index)
    {   // Too few old buttons, need to make new ones.
        
        UILabel* key = [[UILabel alloc] init];
        
        key.frame = CGRectMake( (index%columns)*widthPerButton,
                               (index/columns)*heightPerButton,
                               widthPerButton,
                               heightPerButton);
        
        [key setText:@""];
        [key setTextColor:self.view.tintColor];
        [key setTextAlignment:NSTextAlignmentCenter];
        
        key.tag = index;
        
        [key setUserInteractionEnabled:NO];
        
        [_keys addObject:key];
        [self.view addSubview:key];
    }
    
    for(int j = _keys.count - 1; j >= index; --j)
    {   // Too many buttons, get rid of extras.
        // Removing them starting from the end should be faster.
        UILabel* key = _keys[j];
        
        [key removeFromSuperview];
        [_keys removeObjectAtIndex:j];
    }
}

/**
 * Detect when any touches begin anywhere in the keyboard area.
 * If it was on a key, perform its function.
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    int index = -1;
    
    UITouch* touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    for(UILabel* key in _keys)
    {
        if([key pointInside:[self.view convertPoint:location toView:key] withEvent:nil])
        {
            index = key.tag;
            break;
        }
    }
    
    if(index != -1 ) [_delegate keyUsed:index type:ActionTypeTouchDown];
}

/**
 * Detects when a touch THAT BEGAN anywhere in the keyboard area, ends ANYWHERE AT ALL.
 * Problems:
 * (1) Starting a touch on a key that doesn't have a subset (like "SPACE")
 *      Lifting over a key that does will enter its subset when its not supposed to.
 * (2) Touching a key with a subset then lifting over something that's not a key doesn't reset the keyboard yet.
 * Solution ideas:
 *      (1) Should be able to fix by checking whether the ActoinType was
 *      TouchDown or LiftUp when performing an action. *
 *      (2) Should be able to fix by sending a special message to _delegate ("-1"?) when there is a lift but no key.
 */
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    int index = -1;
    UITouch* touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    for(UILabel* key in _keys)
    {
        if([key pointInside:[self.view convertPoint:location toView:key] withEvent:nil])
        {
            index = key.tag;
        }
    }
    [_delegate keyUsed:index type:ActionTypeLiftUp];
}

/** Update text of all keys. */
-(void)updateLayoutViewWithStrings:(NSArray*)strings
{
    int index;
    
    for(index = 0; index < MIN(_rows * _columns, strings.count); ++index)
    {   // Update existing buttons.
        UILabel* key = _keys[index];
        NSString* text = strings[index];
        
        if([text length] > 0)
        {
            key.hidden = NO;
            [key setText:text];
        }
        else
        {
            [key setText:@""];
            key.hidden = YES;
        }
    }
    
    for(; index < _rows*_columns; ++index)
    {   // Not enough strings. Just disable the remaining buttons.
        UILabel* key = _keys[index];
        
        key.hidden = YES;
    }
    
    // If there were even more strings, just ignore them.
}

@end
