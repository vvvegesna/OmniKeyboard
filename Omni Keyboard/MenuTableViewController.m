//
//  ConfigTableViewController.m
//  Omni Keyboard
//
//  Created by Sky on 10/2/16.
//  Copyright © 2016 Sky. All rights reserved.
//

#import "MenuTableViewController.h"
#import "KeyboardSelectorTableViewController.h"
#import "KeyboardsDownloadVC.h"

@interface MenuTableViewController ()
{
    NSArray* _listItems;
}

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listItems = [[NSMutableArray alloc] initWithObjects:
                  @"Keyboards",
                  @"Download", @"Help",
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
    switch (indexPath.row){
    
    case 0: [self performSegueWithIdentifier:@"ConfigToKeyboardSelectorTable" sender:self];
            break;
    
    case 1: [self performSegueWithIdentifier:@"ConfigToKeyboardsDownload" sender:self];
            break;
        case 2:
            //segue to HelpWindow
            [self performSegueWithIdentifier:@"ConfigToHelpWindow" sender:self];
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
    else if ([[segue identifier] isEqualToString:@"ConfigToKeyboardsDownload"])
    {
        KeyboardsDownloadVC *Kdvc = [segue destinationViewController];
        Kdvc.delegate = self.passDelegate;
    }
}

- (IBAction)buttonDone:(id)sender {
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

@end
