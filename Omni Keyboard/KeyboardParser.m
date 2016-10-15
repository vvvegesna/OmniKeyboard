//
//  KeyboardParser.m
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import "KeyboardParser.h"
#import "Keyset.h"
#import "Key.h"

@interface KeyboardParser()
{
    NSString* keyboardName;
    int columns;
    int rows;
    NSString* initialKeyset;
    
    NSMutableDictionary* keysetDictionanry;
    
    NSString* keysetId;
    
    NSMutableArray* keysArray;
    
    NSString* text;
    NSString* nextKeysetID;
    NSString* action;
    
}
@end

@implementation KeyboardParser

-(KeyboardParser*)init
{
    return [super init];
}

/**
 * Creates a keyboard object using an XML file.
 * @param NSURL* URL  The URL the XML file to parse.
 */

-(Keyboard*)parseKeyboardFromURL:(NSURL*)URL
{
    NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    
    [parser setDelegate:self];
    
    [parser parse];
    return self.keyboard;
}


- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if([elementName isEqualToString:@"Keyboard"])
    {
        self->keyboardName = attributeDict[@"name"];
        self->columns = attributeDict[@"columns"].integerValue;
        self->rows = attributeDict[@"rows"].integerValue;
        self->initialKeyset = attributeDict[@"initial"];
        keysetDictionanry = [[NSMutableDictionary alloc] init];
    }
    else if([elementName isEqualToString:@"Keyset"])
    {
        self->keysetId = attributeDict[@"id"];
        keysArray = [[NSMutableArray alloc] init];
    }
    else if([elementName isEqualToString:@"Key"])
    {
        self->text = attributeDict[@"text"];
        self->nextKeysetID = attributeDict[@"link"];
        self->action = attributeDict[@"action"];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"Keyboard"])
    {
        self.keyboard = [[Keyboard alloc] initWithKeyset:[keysetDictionanry copy]
                                              AndColumns:columns
                                                 AndRows:rows
                                        AndInitialKeyset:initialKeyset];
    }
    else if([elementName isEqualToString:@"Keyset"])
    {        
        self->keysetDictionanry[keysetId] = [[Keyset alloc] initWithKeys:[keysArray copy]];
    }
    else if([elementName isEqualToString:@"Key"])
    {
        [keysArray addObject:[[Key alloc] initWithText:text
                                         AndNextKeysetID:nextKeysetID
                                             AndAction:action]];
    }
}

@end











