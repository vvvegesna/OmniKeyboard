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

@end

@implementation KeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KeyboardParser* parser = [[KeyboardParser alloc] init];
    
    Keyboard* board = [parser parseKeyboardXML:@"Default"];
    
    Keyset* keyset1 = board.Keysets[@"l_abcd"];
    
    Key* key1_1 = keyset1.keys[1];
    
    NSLog(@"Keyset: %@", keyset1);
    NSLog(@"Key: %@", key1_1);
    
    NSLog(@"Key ['l_abcd'][2]'s text is: %@", key1_1.text);
}

- (IBAction)didPressConfig:(id)sender {
    [self performSegueWithIdentifier:@"keyboardToConfig" sender:self];
}

- (IBAction)unwindToKeyboard:(UIStoryboardSegue*)segue
{
    
}

@end
