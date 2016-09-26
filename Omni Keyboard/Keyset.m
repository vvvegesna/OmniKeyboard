//
//  Keyset.m
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import "Keyset.h"

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

@end
