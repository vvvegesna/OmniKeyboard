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
    
    //_buttons = [[NSMutableArray alloc] init];
    
    KeyboardParser* parser = [[KeyboardParser alloc] init];
    
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"Default" withExtension:@"xml" ];
    _board = [parser parseKeyboardFromURL:url];
    
    _currentKeyset = _board.keysets[_board.initialKeyset];
    
    [_keyArea newLayoutWithRows:_board.rows columns:_board.columns];
    [_keyArea updateLayoutViewWithStrings:[_currentKeyset getKeyStrings]];
    
    /*
    [self newLayoutWithRows:_board.rows columns:_board.columns];
    [self updateLayoutViewWithStrings:[_currentKeyset getKeyStrings]];
     */
}

- (IBAction)didPressCut:(id)sender {
    UIPasteboard *cp = [UIPasteboard generalPasteboard];
    [cp setString: [_textView text]];
    _textView.text = @"";
}

- (IBAction)didPressCopy:(id)sender {
    UIPasteboard *cp = [UIPasteboard generalPasteboard];
    [cp setString: [_textView text]];
}

- (IBAction)didPressClear:(id)sender {
    _textView.text = @"";
}

- (IBAction)didPressConfig:(id)sender {
    [self performSegueWithIdentifier:@"keyboardToConfig" sender:self];
}

-(void)changeLayoutWithKeysetID:(NSString*)keysetID
{
    _currentKeyset = _board.keysets[keysetID];
    [_keyArea updateLayoutViewWithStrings:[_currentKeyset getKeyStrings]];
}

/*
-(void)newLayoutWithRows:(int)rows columns:(int)columns
{
    
    self->_rows = rows;
    self->_columns = columns;
    
    //int usableWidth = _keyArea
    
    int usableWidth = _keyArea.view.bounds.size.width;//_keyboardView.bounds.size.width;
    int usableHeight = _keyArea.view.bounds.size.height;//_keyboardView.bounds.size.height;
    //int usableWidth = self.view.bounds.size.width;
    //int usableHeight = (1.0/2.0) * self.view.bounds.size.height;
    
    int startingHeight = self.view.bounds.size.height - usableHeight;
    
    int widthPerButton = usableWidth/columns;
    int heightPerButton = usableHeight/rows;
    
    int index;
    for(index = 0; index < MIN(rows*columns, _buttons.count); ++index)
    {   // Reposition existing buttons
        UIButton* btn = _buttons[index];
        btn.frame = CGRectMake( (index%columns)*widthPerButton,
                               (index/columns)*heightPerButton + startingHeight,
                               widthPerButton,
                               heightPerButton);
    }
    
    for(; index < rows*columns; ++index)
    {   // Too few old buttons, need to make new ones.
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake( (index%columns)*widthPerButton,
                               (index/columns)*heightPerButton + startingHeight,
                               widthPerButton,
                               heightPerButton);
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didPressKey:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = index;
        [_buttons addObject:btn];
        [self.view addSubview:btn];
    }
    
    for(int j = _buttons.count - 1; j >= index; --j)
    {   // Too many buttons, get rid of extras. Removing from the end should be faster.
        UIButton* btn = _buttons[j];
        
        [btn removeFromSuperview];
        [_buttons removeObjectAtIndex:j];
    }
}

-(void)updateLayoutViewWithStrings:(NSArray*)strings
{
    int index;
    
    for(index = 0; index < MIN(_rows * _columns, strings.count); ++index)
    {   // Update existing buttons.
        UIButton* btn = _buttons[index];
        NSString* text = strings[index];
        
        if([text length] > 0)
        {
            btn.hidden = NO;
            [btn setTitle:text forState:UIControlStateNormal];
        }
        else
        {
            [btn setTitle:@"" forState:UIControlStateNormal];
            btn.hidden = YES;
        }
    }
    
    for(; index < _rows*_columns; ++index)
    {   // Not enough strings. Just disable the remaining buttons.
        UIButton* btn = _buttons[index];
        
        btn.hidden = YES;
    }
    
    // If there were even more strings, just ignore them.
}
*/

-(void)keyUsed:(int)index type:(ActionType)type
{
    /*
    NSLog(@"Key with index %i activated with action ID %u", index, type);
    
    if(type == ActionTypeTouchDown)
    {
        NSLog(@"Action was touch down");
    }
    */
    
    Key* pressedKey = _currentKeyset.keys[index];
    
    if(pressedKey.action != nil)
    {
        if([pressedKey.action isEqualToString:@"SPACE"])
        {
            _textView.text = [_textView.text stringByAppendingString:@" "];
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
        _textView.text = [_textView.text stringByAppendingString:pressedKey.text];
        [self changeLayoutWithKeysetID:_board.initialKeyset];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"keyboardEmbedsKeyArea"])
    {
        _keyArea = segue.destinationViewController;
        _keyArea.delegate = self;
    }
    
    
}

@end
