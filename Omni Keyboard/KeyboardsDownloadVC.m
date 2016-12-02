//
//  KeyboardsDownloadVC.m
//  Omni Keyboard
//
//  Created by Vijay Varma on 11/25/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import "KeyboardsDownloadVC.h"

@interface KeyboardsDownloadVC ()
{
    NSMutableArray* _XMLs;
}
@end
@implementation KeyboardsDownloadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_Indicator startAnimating];
}
-(void) viewWillAppear:(BOOL)animated{
    NSURL* url = [NSURL URLWithString:@"http://google.com"];
    
    NSURLSessionDataTask* dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
       if(!error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //NSLog(@"connected!");
                [_Indicator stopAnimating];
                _XMLs = [[NSMutableArray alloc] initWithCapacity:1];
                NSURL *uri1 = [[NSURL alloc] initWithString:@"http://dcm.uhcl.edu/c533316fa03vegesnav/Dvorak.xml"];
                [_XMLs addObject:uri1];
                NSURL *uri2 = [[NSURL alloc] initWithString:@"http://dcm.uhcl.edu/c533316fa03vegesnav/QWERTY.xml"];
                [_XMLs addObject:uri2];
                [self.tableView reloadData];
            });
        }
        else
        {
            //NSLog(@"URL Communication Error");
            dispatch_async(dispatch_get_main_queue(), ^{
            [_Indicator stopAnimating];
            [self.navigationController popToRootViewControllerAnimated:YES];
            });
           
        }
        
    }];
    
    [dataTask resume];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_XMLs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadcell" forIndexPath:indexPath];
    // Configure the cell...
    NSURL* url = ((NSURL*)[_XMLs objectAtIndex:indexPath.row]);
    url = [url URLByDeletingPathExtension];
    NSString* name = [url lastPathComponent];
    
    cell.textLabel.text = name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate changeKeyboardUrl:_XMLs[indexPath.row]];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
