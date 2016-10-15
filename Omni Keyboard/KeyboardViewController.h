//
//  ViewController.h
//  XMLParserTest
//
//  Created by Baker, Cody on 9/20/16.
//  Copyright © 2016 UCHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardViewController : UIViewController
- (IBAction)didPressConfig:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)didPressCopy:(id)sender;
- (IBAction)didPressCut:(id)sender;
- (IBAction)didPressClear:(id)sender;

- (IBAction)unwindToKeyboard:(UIStoryboardSegue*)segue;

@end

