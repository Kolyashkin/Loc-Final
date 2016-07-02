//
//  databaseObject.h
//  Loc-Final
//
//  Created by Nickolas McDaniels on 6/26/16.
//  Copyright © 2016 Nickolas Donnell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface databaseObject : NSObject
@property (strong, nonatomic) NSString *filePath;
-(NSString*) getDbFilePath;
-(int) createTable;
-(int) insert: (float) lat : (float) longitude : (NSDate *)datestamp : (NSDate *)timestamp;
-(NSMutableArray*) getLocations;
@end
