//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Wade Sellers on 10/6/14.
//  Copyright (c) 2014 Wade Sellers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *addItemField;
@property (weak, nonatomic) IBOutlet UITableView *errandsTableView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property NSMutableArray *checkedIndexPath;
@property NSMutableArray *errands;
@property NSIndexPath *alertIndexPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.errands = [NSMutableArray arrayWithObjects:@"Milk the Cows",
                    @"Gather Chicken Eggs",
                    @"Feed the Goats",
                    @"Build a Barn",
                    @"Fix the Tractor",
                    @"Darn My Socks",
                    @"Beat Dust Out Of Rug",
                    @"ReShoe the Horses",
                    @"Sharpen Pitchfork",
                    @"Repair the Ole Pickup",
                    @"Do Some Garden'n",
                    @"Knockin Up The Ole Lady",
                    @"Work On Line Dance",
                    @"Yell At Children",
                    @"ReHang No Tresspassing Signs", nil];

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

//This sets up the tableview to ask datasource to make a change when told to.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.alertIndexPath = indexPath;

    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                        message:@"Are you sure?"
                                                       delegate:self
                                              cancelButtonTitle:@"NO"
                                              otherButtonTitles:@"YES", nil];
        [alert show];
        [tableView reloadData];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.errands removeObjectAtIndex:self.alertIndexPath.row];
        [self.errandsTableView reloadData];
    }
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

- (IBAction)onEditButtonPressed:(UIButton *)sender
{
    [self.editButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.errandsTableView setEditing: YES animated: YES];

    if ([self.editButton.titleLabel.text containsString:@"Done"])
    {
        [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [self.errandsTableView setEditing: NO animated: YES];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (IBAction)onSwipeRight:(UIGestureRecognizer *)swipeGesture
{
    CGPoint location = [swipeGesture locationInView:self.errandsTableView];
    NSIndexPath *indexPath = [self.errandsTableView indexPathForRowAtPoint:location];
    if (indexPath)
    {
        UITableViewCell *cell = [self.errandsTableView cellForRowAtIndexPath:indexPath];

        if (cell.tag == 0) {
            cell.backgroundColor = [UIColor redColor];
            cell.tag++;
        }
        else if (cell.tag == 1)
        {
            cell.backgroundColor = [UIColor yellowColor];
            cell.tag++;
        }
        else if (cell.tag == 2)
        {
            cell.backgroundColor = [UIColor greenColor];
            cell.tag++;
        }
        else if (cell.tag == 3)
        {
            cell.tag = 0;
            cell.backgroundColor = [UIColor whiteColor];
        }
    }
}

@end
