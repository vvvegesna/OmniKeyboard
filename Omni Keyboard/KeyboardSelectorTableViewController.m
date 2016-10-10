//
//  KeyboardTableViewController.m
//  Omni Keyboard
//
//  Created by Sky on 10/9/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import "KeyboardSelectorTableViewController.h"

/*
 #import "KeyboardParser.h"
 #import "Keyset.h"
 #import "Key.h"
 */

@interface KeyboardSelectorTableViewController ()
{
    NSArray* _XMLURLs;
}

@end

@implementation KeyboardSelectorTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSURL* docDir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    //NSLog(@"Documents Directory: %@", docDir);
    
    NSArray* docs = [self filesAtURL:docDir];
    
    _XMLURLs = [docs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension='xml'"]];
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
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_XMLURLs count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"keyboardSelectorCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSURL* url = ((NSURL*)[_XMLURLs objectAtIndex:indexPath.row]);
    url = [url URLByDeletingPathExtension];
    NSString* name = [url lastPathComponent];
    
    cell.textLabel.text = name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: parse xml file, update model, update view
}
- (IBAction)didPressDone:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

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
