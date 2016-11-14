//
//  ConfigTableViewController.m
//  Omni Keyboard
//
//  Created by Sky on 10/2/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import "MenuTableViewController.h"
#import "KeyboardSelectorTableViewController.h"

@interface MenuTableViewController ()
{
    NSArray* _listItems;
}

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listItems = [[NSArray alloc] initWithObjects:
                  @"Keyboards",
                  @"Download",
                  nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"configCell" forIndexPath:indexPath];
    
    //Configure the cell...
    cell.textLabel.text = _listItems[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch(indexPath.row)
    {
        case 0:
            // segue to KeyboardsTableViewController
            [self performSegueWithIdentifier:@"ConfigToKeyboardSelectorTable" sender:self];
            break;
        case 1:
            // segue to DownloadViewController
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ConfigToKeyboardSelectorTable"])
    {
        KeyboardSelectorTableViewController *Kstvc = [segue destinationViewController];
        Kstvc.delegate = self.passDelegate;
    }
}


/** Returns to first view in NavigationController---the Keyboard. */
- (IBAction)didPressDone:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
