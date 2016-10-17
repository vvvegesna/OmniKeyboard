//
//  ViewController.h
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewControllerDelegate.h"

@interface KeyboardViewController : UIViewController <KeyboardViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;



- (IBAction)didPressConfig:(id)sender;
- (IBAction)didPressCopy:(id)sender;
- (IBAction)didPressCut:(id)sender;
- (IBAction)didPressClear:(id)sender;

-(void)keyUsed:(int)index type:(ActionType)type;

@end

