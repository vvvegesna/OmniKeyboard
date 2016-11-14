//
//  ViewController.h
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewControllerDelegate.h"
#import "changeKeyboard.h"
@interface KeyboardViewController : UIViewController <KeyboardViewControllerDelegate, changeKeyboard>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property NSURL* url;

- (IBAction)didPressMenu:(id)sender;
- (IBAction)didPressCopy:(id)sender;
- (IBAction)didPressCut:(id)sender;
- (IBAction)didPressClear:(id)sender;

-(void)keyUsed:(int)index type:(ActionType)type;

@end

