//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Wade Sellers on 10/6/14.
//  Copyright (c) 2014 Wade Sellers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property NSMutableArray *errands;
@property (weak, nonatomic) IBOutlet UITextField *addItemField;
@property (weak, nonatomic) IBOutlet UITableView *errandsTableView;
@property NSMutableArray *checkedIndexPath;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.errands = [NSMutableArray arrayWithObjects:@"Take out trash",
                    @"Do dishes",
                    @"Clean room",
                    @"Vacuum", nil];

    //This is assigning an array of NO's for as many objects are in our errands array
    self.checkedIndexPath = [NSMutableArray arrayWithCapacity:self.errands.count];
    for (int i = 0; i < self.errands.count; i++)
    {
        [self.checkedIndexPath addObject:[NSNumber numberWithBool:NO]];
    }
    
}

//This tells my TableView how many rows it needs to build
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.errands.count;
}

// This tells what to put into each cell as it goes down the array, it will populate that many cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"toDoItems" forIndexPath:indexPath];

    cell.textLabel.text = [self.errands objectAtIndex:indexPath.row];
    return cell;
}

//When I tap the add button, add the object in the textfield to the array, empty the textfield, drop the keyboard, and reload the tableview so we see the new item.
- (IBAction)onTappedAddButton:(id)sender
{
    [self.errands addObject:self.addItemField.text];
    [self.checkedIndexPath addObject:[NSNumber numberWithBool:NO]];
    self.addItemField.text = @"";
    [self.addItemField resignFirstResponder];
    [self.errandsTableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.errands removeObjectAtIndex:indexPath.row];

    [tableView reloadData];
}

//When you select a cell, check to see if that cell has any accessories, if not give it 1.
//If it does have an accessory, take it away.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([self.editButton.titleLabel.text containsString:@"Done"])
    {
        [self.errands removeObjectAtIndex:indexPath.row];
        [tableView reloadData];

    }

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.checkedIndexPath replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.checkedIndexPath replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
    }
}

- (IBAction)onEditButtonPressed:(id)sender
{
    [self.editButton setTitle:@"Done" forState:normal];
    if ([self.editButton.titleLabel.text containsString:@"Done"])
    {
        [self.editButton setTitle:@"Edit" forState:normal];
    }
}

- (IBAction)onSwipeRight:(id)sender
{

}






@end
