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
#import "MenuTableViewController.h"

@interface KeyboardViewController ()
{
    Keyboard* _board;
    Keyset* _currentKeyset;
    KeyAreaViewController* _keyArea;
    KeyboardParser* _parser;
}
@end

@implementation KeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Create the keyboard parser
    _parser = [[KeyboardParser alloc] init];
    
    // Usable width is the whole width.
    // Usable height is everything below the bottom of the textView.
    int usableWidth = self.view.frame.size.width;
    int usableHeight = self.view.frame.size.height - (self.textView.frame.size.height + self.textView.frame.origin.y);
    
    // Create the Key Area, and initialize it with the default layout.
    _keyArea = [[KeyAreaViewController alloc] initWithFrame:CGRectMake(0, 0, usableWidth, usableHeight)];
    _keyArea.delegate = self;
    
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"Wide" withExtension:@"xml" ];
    
    [self changeKeyboardUrl:url];
    
    // Set the Key Area we just created as the pop-out keyboard for the textView.
    self.textView.inputView = _keyArea.view;
}

-(void) changeKeyboardUrl:(NSURL *)name
{
    _board = [_parser parseKeyboardFromURL:name];
    _currentKeyset = _board.keysets[_board.initialKeyset];
    [_keyArea newLayoutWithRows:_board.rows columns:_board.columns];
    [_keyArea updateLayoutViewWithStrings:[_currentKeyset getKeyStrings]];    
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
- (IBAction)didPressMenu:(id)sender {
    [self performSegueWithIdentifier:@"keyboardToConfig" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"keyboardToConfig"])
    {
       MenuTableViewController *Mtvc = [segue destinationViewController];
        Mtvc.passDelegate = self;
    }
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
-(void) keyNotUsed{
    [self changeLayoutWithKeysetID:_board.initialKeyset];
}

-(void)keyUsed:(int)index type:(ActionType)type
{
    if(index == -1 && type == ActionTypeLiftUp) {
        [self keyNotUsed];
        return;
    }
    
    Key* pressedKey = _currentKeyset.keys[index];
    
    if(pressedKey.action != nil)
    {
        if (type == ActionTypeLiftUp)
        {
            if([pressedKey.action isEqualToString:@"SPACE"])
            {
                [self insertTextAtCursor:@" "];
            }
            else if([pressedKey.action isEqualToString:@"ENTER"])
            {
				[self insertTextAtCursor:@"\n"];
			}
            
            else if([pressedKey.action isEqualToString:@"DELETE"])
            {
                [self RemoveCharacter];                
            }
        }
    }
    else if(pressedKey.nextKeysetID != nil)
    {
        [self changeLayoutWithKeysetID:pressedKey.nextKeysetID];
    }
    else if(pressedKey.text != nil)
    {
        if(type == ActionTypeLiftUp)
        {
            [self insertTextAtCursor:pressedKey.text];
                
            [self changeLayoutWithKeysetID:_board.initialKeyset];
        }
    }
    else
    {
        [self keyNotUsed];
    }
}

-(void) insertTextAtCursor: (NSString *) text
{
    NSRange range;
    NSMutableString *string = [_textView.text mutableCopy];
    range = _textView.selectedRange;
    if (range.length>0)
    {
        [string deleteCharactersInRange:range];
        range.length=0;
    }
    [string insertString:text atIndex:range.location];
    [_textView setText:string];
    range.location += [text length];
    _textView.selectedRange = range;    
}

-(void)RemoveCharacter
{
    NSRange range = _textView.selectedRange;
    
    NSMutableString* text = [_textView.text mutableCopy];
    
    if(range.length == 0 && range.location > 0 )
    {
        --range.location;
        range.length = 1;
        [text deleteCharactersInRange:range];
    }
    else if(range.length > 0)
    {
        [text deleteCharactersInRange:range];
    }
    
    range.length = 0;
    [_textView setText:text];
    [_textView setSelectedRange:range];
    
}

@end
