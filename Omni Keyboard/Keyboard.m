//
//  Keyboard.m
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import "Keyboard.h"

@implementation Keyboard

-(Keyboard*)initWithKeyset:(NSDictionary *)KeysetDict
           AndColumns:(int)columns
              AndRows:(int)rows
     AndInitialKeyset:(NSString*) initKeyset
{
    self = [super init];
    if(self)
    {
        self.Keysets = KeysetDict;
        self.columns = columns;
        self.rows = rows;
        self.initialKeyset = initKeyset;
    }
    return self;
}

@end
