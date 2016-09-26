//
//  ViewController.m
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardParser.h"
#import "Keyset.h"
#import "Key.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KeyboardParser* parser = [[KeyboardParser alloc] init];
    
    Keyboard* board = [parser parseKeyboardXML:@"Default"];
    
    Keyset* keyset1 = board.Keysets[@"l_abcd"];
    
    Key* key1_1 = keyset1.keys[0];
    
    NSLog(@"Keyset: %@", keyset1);
    NSLog(@"Key: %@", key1_1);
    
    NSLog(@"Key ['l_abcd'][2]'s text is: %@", key1_1.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
