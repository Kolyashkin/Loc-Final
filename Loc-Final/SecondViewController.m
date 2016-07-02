//
//  SecondViewController.m
//  Loc-Final
//
//  Created by Nickolas McDaniels on 6/26/16.
//  Copyright © 2016 Nickolas Donnell. All rights reserved.
//

#import "SecondViewController.h"
#import "locationDisplayViewController.h"
#import "databaseObject.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationsArray = [[NSMutableArray alloc] init];
    [_locationsArray removeAllObjects];
    
    _locationToPush = [[NSMutableDictionary alloc] init];
    [_locationToPush removeAllObjects];
    _dbObj1 = [[databaseObject alloc] init];
    
    _locationsArray = [_dbObj1 getLocations];
    
    [_locationTable setDelegate:self];
    [_locationTable setDataSource:self];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu", (unsigned long)[_locationsArray count]);
    return [_locationsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"locationCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"date: %@ time: %@", [[_locationsArray objectAtIndex:indexPath.row] valueForKey:@"date"], [[_locationsArray objectAtIndex:indexPath.row] valueForKey:@"time"]];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    locationDisplayViewController *destination = [[locationDisplayViewController alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    destination = (locationDisplayViewController *)[storyboard instantiateViewControllerWithIdentifier:@"locationDisplayView"];
    destination.locationRecord = [_locationsArray objectAtIndex:indexPath.row];
    
    [[self navigationController] pushViewController:destination animated:YES];
    
}
@end