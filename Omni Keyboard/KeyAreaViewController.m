//
//  KeyboardArea.m
//  Omni Keyboard
//
//  Created by Sky on 10/17/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import "KeyAreaViewController.h"

@interface KeyAreaViewController ()
{
    int _rows;
    int _columns;
    NSMutableArray* _keys;
    
    id <KeyboardViewControllerDelegate> _delegate;
}

@end

@implementation KeyAreaViewController

@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _keys = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)newLayoutWithRows:(int)rows columns:(int)columns
{    
    _rows = rows;
    _columns = columns;
    
    int usableWidth = self.view.bounds.size.width;
    int usableHeight = self.view.bounds.size.height;
    
    int widthPerButton = usableWidth/columns;
    int heightPerButton = usableHeight/rows;
    
    int index;
    for(index = 0; index < MIN(rows*columns, _keys.count); ++index)
    {   // Reposition existing buttons
        UIButton* btn = _keys[index];
        btn.frame = CGRectMake( (index%columns)*widthPerButton,
                               (index/columns)*heightPerButton,
                               widthPerButton,
                               heightPerButton);
    }
    
    for(; index < rows*columns; ++index)
    {   // Too few old buttons, need to make new ones.
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake( (index%columns)*widthPerButton,
                               (index/columns)*heightPerButton,
                               widthPerButton,
                               heightPerButton);
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didPressKey:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = index;
        [_keys addObject:btn];
        [self.view addSubview:btn];
    }
    
    for(int j = _keys.count - 1; j >= index; --j)
    {   // Too many buttons, get rid of extras.
        // Removing them starting from the end should be faster.
        UIButton* btn = _keys[j];
        
        [btn removeFromSuperview];
        [_keys removeObjectAtIndex:j];
    }
}

-(IBAction)didPressKey:(id)sender
{
    UIButton* btn = sender;
    
    [_delegate keyUsed:btn.tag type:ActionTypeTouchDown];
}

-(void)updateLayoutViewWithStrings:(NSArray*)strings
{
    int index;
    
    for(index = 0; index < MIN(_rows * _columns, strings.count); ++index)
    {   // Update existing buttons.
        UIButton* btn = _keys[index];
        NSString* text = strings[index];
        
        if([text length] > 0)
        {
            btn.hidden = NO;
            [btn setTitle:text forState:UIControlStateNormal];
        }
        else
        {
            [btn setTitle:@"" forState:UIControlStateNormal];
            btn.hidden = YES;
        }
    }
    
    for(; index < _rows*_columns; ++index)
    {   // Not enough strings. Just disable the remaining buttons.
        UIButton* btn = _keys[index];
        
        btn.hidden = YES;
    }
    
    // If there were even more strings, just ignore them.
}

@end
