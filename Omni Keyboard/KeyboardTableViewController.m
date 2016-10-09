//
//  KeyboardTableViewController.m
//  Omni Keyboard
//
//  Created by Sky on 10/9/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import "KeyboardTableViewController.h"

/*
 #import "KeyboardParser.h"
 #import "Keyset.h"
 #import "Key.h"
 */

@interface KeyboardTableViewController ()

@end

@implementation KeyboardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSURL* docDir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    NSArray* docs = [self filesAtURL:docDir];
    
    NSArray* xmls = [docs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension='xml'"]];
    
    NSLog(@"URLS: %@", xmls);
    
    /*
     KeyboardParser* parser = [[KeyboardParser alloc] init];
     
     Keyboard* keyboard = [parser parseKeyboardFromURL:docs[1]];
     
     NSLog(@"Keyboard: %@", keyboard);
     
     Keyset* keyset = keyboard.keysets[@"l_abcd"];
     
     NSLog(@"Keyset: %@", keyset);
     
     Key* key = keyset.keys[0];
     
     NSLog(@"Key: %@", key);
     NSLog(@"Key's text: %@", key.text);
     */
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(NSArray*)filesAtURL:(NSURL*)URL
{
    NSArray* directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:URL
                                                              includingPropertiesForKeys:nil
                                                                                 options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                                   error:nil];
    
    if(directoryContent)
    {
        return directoryContent;
    }
    else
    {
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
