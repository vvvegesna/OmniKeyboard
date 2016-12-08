//
//  KeyboardTableViewController.m
//  Omni Keyboard
//
//  Created by Sky on 10/9/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import "KeyboardSelectorTableViewController.h"

@interface KeyboardSelectorTableViewController ()
{
    NSArray* _XMLURLs;
}

@end

@implementation KeyboardSelectorTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Gets the Documents directory.
    NSURL* docDir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        // Gets the list of documents in the Documents directory (might include folders?)
        NSArray* docs = [self filesAtURL:docDir];
        
        // Only consider .xml files.
    _XMLURLs = [docs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension='xml'"]];
    
}


///** Gets a list of files from the specified URL. */
-(NSArray*)filesAtURL:(NSURL*)URL
{
    NSArray* directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:URL
                                                              includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
        if(directoryContent)
    {
        return directoryContent;
    }
    else
    {
        return nil;
    }
}

#pragma mark - Table view data source

///** Consider having seperate sections for DEFAULT layouts vs IMPORTED/DOWNLOADED layouts */
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
    BOOL valid = [self.delegate changeKeyboardUrl:_XMLURLs[indexPath.row]];
    if(valid)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        // Invalid layout error
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Layout is invalid." message:@"See the \"Help\" page for layout structure information.\nCurrent layout not changed." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)buttonDone:(id)sender {
    [[self navigationController] popToRootViewControllerAnimated:YES];
}
@end
