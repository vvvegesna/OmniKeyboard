//
//  Keyset.m
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import "Keyset.h"
#import "Key.h"

@implementation Keyset

-(Keyset*)initWithKeys:(NSArray*)keys
{
    self = [super init];
    if(self)
    {
        self.keys = keys;
    }
    return self;
}

/** Gets text text from all the keys and returns an immutable NSArray containing the strings. */
-(NSArray*)getKeyStrings
{
    NSMutableArray* strings = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < self.keys.count; ++i)
    {
        Key* key = self.keys[i];
        NSString* text = key.text;
        
        if(text == nil)
        {
            text = @"";
        }
        
        [strings addObject:text];
    }
    
    return [strings copy];
}

@end
