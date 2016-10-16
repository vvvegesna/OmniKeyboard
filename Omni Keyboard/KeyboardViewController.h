//
//  ViewController.h
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewControllerDelegate.h"

@class KeyboardArea;

@interface KeyboardViewController : UIViewController <KeyboardViewControllerDelegate>
- (IBAction)didPressConfig:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet KeyboardArea *keyboardView;

- (IBAction)didPressCopy:(id)sender;
- (IBAction)didPressCut:(id)sender;
- (IBAction)didPressClear:(id)sender;

- (IBAction)unwindToKeyboard:(UIStoryboardSegue*)segue;

-(void)keyActivated:(int)index action:(ActionType)action;

@end

