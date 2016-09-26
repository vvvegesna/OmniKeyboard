//
//  Key.m
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import "Key.h"

@implementation Key

-(Key*)initWithText:(NSString*)text
      AndNextKeyset:(NSString*)nextKeyset
          AndAction:(NSString*)action
{
    self = [super init];
    if(self)
    {
        self.text = text;
        self.nextKeyset  = nextKeyset;
        self.action = action;
    }
    return self;
}

@end
