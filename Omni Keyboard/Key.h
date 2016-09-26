//
//  Key.h
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Key : NSObject


@property NSString* text;
@property NSString* nextKeyset;
@property NSString* action;

-(Key*)initWithText:(NSString*)text
      AndNextKeyset:(NSString*)nextKeyset
          AndAction:(NSString*)action;

@end
