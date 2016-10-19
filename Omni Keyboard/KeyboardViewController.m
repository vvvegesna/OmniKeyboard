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
    
    KeyboardParser* parser = [[KeyboardParser alloc] init];
    
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"Default" withExtension:@"xml" ];
    _board = [parser parseKeyboardFromURL:url];
    
    _currentKeyset = _board.keysets[_board.initialKeyset];
    
    
    int usableWidth = self.view.frame.size.width;
    int usableHeight = self.view.frame.size.height - (self.textView.frame.size.height + self.textView.frame.origin.y);
    
    _keyArea = [[KeyAreaViewController alloc] initWithFrame:CGRectMake(0, 0, usableWidth, usableHeight)];
    _keyArea.delegate = self;
    [_keyArea newLayoutWithRows:_board.rows columns:_board.columns];
    [_keyArea updateLayoutViewWithStrings:[_currentKeyset getKeyStrings]];
    
    self.textView.inputView = _keyArea.view;
}
-(void)viewDidLayoutSubviews
{
    [self.textView setContentOffset:CGPointZero animated:NO];
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
    self.textView.inputView = _keyArea.view;
}

-(void)keyUsed:(int)index type:(ActionType)type
{
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

@end
