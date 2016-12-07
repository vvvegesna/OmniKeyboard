//
//  Keyboard.h
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Keyboard : NSObject

@property NSString* name;
@property int rows;
@property int columns;
@property NSString* initialKeyset;

@property NSDictionary* keysets;

-(Keyboard*)initWithContentsOfURL:(NSURL*)url;

-(Keyboard*)initWithKeyset:(NSDictionary *)KeysetDict AndColumns:(int)columns AndRows:(int)rows AndInitialKeyset:(NSString*) initKeyset;


@end
