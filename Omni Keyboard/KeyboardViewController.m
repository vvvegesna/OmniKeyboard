//
//  ViewController.m
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import "KeyboardViewController.h"
#import "KeyboardParser.h"
#import "Keyset.h"
#import "Key.h"

#import "KeyAreaViewController.h"

@interface KeyboardViewController ()
{
    Keyboard* _board;
    Keyset* _currentKeyset;
    
    KeyAreaViewController* _keyArea;
}
@end

@implementation KeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create the keyboard parser and parse the default keyboard.
    KeyboardParser* parser = [[KeyboardParser alloc] init];
    
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"Default" withExtension:@"xml" ];
    _board = [parser parseKeyboardFromURL:url];
    
    // Get the initial keyset for the keyboard and set it as the current keyset.
    _currentKeyset = _board.keysets[_board.initialKeyset];
    
    // Usable width is the whole width.
    // Usable height is everything below the bottom of the textView.
    int usableWidth = self.view.frame.size.width;
    int usableHeight = self.view.frame.size.height - (self.textView.frame.size.height + self.textView.frame.origin.y);
    
    // Create the Key Area, and initialize it with the default layout.
    _keyArea = [[KeyAreaViewController alloc] initWithFrame:CGRectMake(0, 0, usableWidth, usableHeight)];
    _keyArea.delegate = self;
    [_keyArea newLayoutWithRows:_board.rows columns:_board.columns];
    [_keyArea updateLayoutViewWithStrings:[_currentKeyset getKeyStrings]];
    
    // Set the Key Area we just created as the pop-out keyboard for the textView.
    self.textView.inputView = _keyArea.view;
}


/** Copies all the text in textView and puts it in iOS's pasteboard. */
- (IBAction)didPressCopy:(id)sender {
    
    UIPasteboard *cp = [UIPasteboard generalPasteboard];
    [cp setString: [_textView text]];
}

/** Removes all the text in textView. */
- (IBAction)didPressClear:(id)sender {
    
    _textView.text = @"";
}

/** Copies, then Clears */
- (IBAction)didPressCut:(id)sender {
    
    [self didPressCopy:nil];
    [self didPressClear:nil];
}

/** Go to the menu. */
- (IBAction)didPressMenu:(id)sender{
    [self performSegueWithIdentifier:@"keyboardToConfig" sender:self];
}

/**
 * Tells key area to update the view. Does not change number of rows or columns.
 * DOES NOT ADD OR DELETE KEYS, but might HIDE some if they have no text (@""=hidden, @" "=blank)
 */
-(void)changeLayoutWithKeysetID:(NSString*)keysetID
{
    _currentKeyset = _board.keysets[keysetID];
    [_keyArea updateLayoutViewWithStrings:[_currentKeyset getKeyStrings]];
}

/** A key is "used" when it is touched, or lifed from.
 * @param   type    whether the action was a TouchDown, or LiftUp.
 */
-(void)keyUsed:(int)index type:(ActionType)type
{
    Key* pressedKey = _currentKeyset.keys[index];
    
    if(pressedKey.action != nil && [_keyArea touchEnd:true])
    {
        if([pressedKey.action isEqualToString:@"SPACE"])
        {
         [self insertTextAtCursor:@" "];
        }
        return;
    }
    
    if(pressedKey.nextKeysetID != nil)
    {
        [self changeLayoutWithKeysetID:pressedKey.nextKeysetID];
        
        return;
    }
    
    if(pressedKey.text != nil)
    {
        [self insertTextAtCursor:pressedKey.text];
        [self changeLayoutWithKeysetID:_board.initialKeyset];
        return;
    }
}
-(void) insertTextAtCursor: (NSString *) text{
    NSRange range;
    NSMutableString *string = [_textView.text mutableCopy];
    range = _textView.selectedRange;
    [string insertString:text atIndex:range.location];
    [_textView setText:string];
    range.location += [text length];
    _textView.selectedRange = range;   
}

@end
