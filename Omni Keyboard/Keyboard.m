//
//  Keyboard.m
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import "Keyboard.h"
#import "KeyboardParser.h"


@implementation Keyboard

-(Keyboard*)initWithContentsOfURL:(NSURL*)url
{
    NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    KeyboardParser* delegate = [[KeyboardParser alloc] init];
    
    [parser setDelegate:delegate];
    
    [parser parse];
    
    return delegate.keyboard;
}

-(Keyboard*)initWithKeyset:(NSDictionary *)KeysetDict
           AndColumns:(int)columns
              AndRows:(int)rows
     AndInitialKeyset:(NSString*) initKeyset
{
    self = [super init];
    if(self)
    {
        self.keysets = KeysetDict;
        self.columns = columns;
        self.rows = rows;
        self.initialKeyset = initKeyset;
    }
    return self;
}

@end
