//
//  SecondViewController.h
//  Loc-Final
//
//  Created by Nickolas McDaniels on 6/26/16.
//  Copyright © 2016 Nickolas Donnell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "databaseObject.h"

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *locationTable;

@property (strong, nonatomic) NSMutableArray *locationsArray;

@property (strong, nonatomic) databaseObject *dbObj1;

@property (strong, nonatomic) NSMutableDictionary *locationToPush;

@end

