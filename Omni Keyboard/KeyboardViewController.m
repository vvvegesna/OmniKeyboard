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

@interface KeyboardViewController ()
{
    int _rows;
    int _columns;
    NSMutableArray* _buttons;
    Keyset* _currentKeyset;
    Keyboard* _board;
}
@end

@implementation KeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    int rows = 4;
    int columns = 4;
     
     
     NSArray* strings = [[NSArray alloc] initWithObjects:
     @"ab", @"cd", @"ef", @"gh",
     @"ij", @"kl", @"mn", @"op",
     @"qr", @"st", @"", @"wx",
     @"yz", @".", @",", @"!?", nil];
    
    [self newLayoutWithRows:rows AndColumns:columns];
    [self updateLayoutWithStrings:strings];
     */
    _buttons = [[NSMutableArray alloc] init];
    
    KeyboardParser* parser = [[KeyboardParser alloc] init];
    
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"Default" withExtension:@"xml" ];
    _board = [parser parseKeyboardFromURL:url];
    
    _currentKeyset = _board.keysets[_board.initialKeyset];
    
    [self newLayoutWithRows:_board.rows AndColumns:_board.columns];
    [self updateLayoutWithStrings:[_currentKeyset getKeyStrings]];
    
    /*
    Keyset* keyset1 = board.keysets[@"l_abcd"];
    
    Key* key1_1 = keyset1.keys[1];
    
    
    NSLog(@"Keyset: %@", keyset1);
    NSLog(@"Key: %@", key1_1);
    
    NSLog(@"Key ['l_abcd'][2]'s text is: %@", key1_1.text);
    */
}

- (IBAction)didPressConfig:(id)sender {
    [self performSegueWithIdentifier:@"keyboardToConfig" sender:self];
}

-(void)newLayoutWithRows:(int)rows AndColumns:(int)columns
{
    self->_rows = rows;
    self->_columns = columns;
    
    
    int usableWidth = self.view.bounds.size.width;
    int usableHeight = (1.0/2.0) * self.view.bounds.size.height;
    
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
        [btn addTarget:self action:@selector(didPressTest:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = index;
        [_buttons addObject:btn];
        [self.view addSubview:btn];
    }
    
    for(int j = _buttons.count - 1; j >= index; --j)
    {   // Too many buttons, get rid of extras.
        UIButton* btn = _buttons[j];
        
        [btn removeFromSuperview];
        [_buttons removeObjectAtIndex:j];
    }
}

-(void)updateLayoutWithStrings:(NSArray*)strings
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

-(IBAction)didPressTest:(id)sender
{
    UIButton* btn = sender;
    
    [self pressedKeyWithIndex:btn.tag];
}

-(void)pressedKeyWithIndex:(int)index
{
    Key* pressedKey = _currentKeyset.keys[index];
    NSString* next = pressedKey.nextKeyset;
    
    if(next != nil)
    {
        NSString* linkName = pressedKey.nextKeyset;
        Keyset* destinationKeyset = _board.keysets[linkName];
        _currentKeyset = destinationKeyset;
        [self updateLayoutWithStrings:[destinationKeyset getKeyStrings]];
        
        return;
    }
    
    if(pressedKey.action != nil)
    {
        return;
    }
    
    if(pressedKey.text != nil)
    {
        NSLog(@"%@", pressedKey.text);
        _currentKeyset = _board.keysets[_board.initialKeyset];
        [self updateLayoutWithStrings:[_currentKeyset getKeyStrings]];
        
    }
    
    
    
    /*
    NSArray* newStr;
    
    switch(index)
    {
        case 1:
            newStr = [[NSArray alloc] initWithObjects:
                      @"1", @"2", @"3", @"4",
                      @"5", @"6", @"7", @"8",
                      @"9", @"",@"11",@"12", nil];
            
            [self newLayoutWithRows:3 AndColumns:4];
            [self updateLayoutWithStrings:newStr];
            break;
    }
    */
}

- (IBAction)unwindToKeyboard:(UIStoryboardSegue*)segue
{
    
}

@end
