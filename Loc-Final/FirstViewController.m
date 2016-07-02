//
//  FirstViewController.m
//  Loc-Final
//
//  Created by Nickolas McDaniels on 6/26/16.
//  Copyright © 2016 Nickolas Donnell. All rights reserved.
//

#import "FirstViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "databaseObject.h"

@interface FirstViewController () <CLLocationManagerDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    _dbObj = [[databaseObject alloc] init];
    
    if([[self locationManager] respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [[self locationManager] requestAlwaysAuthorization];
    }
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:[_dbObj getDbFilePath]])
    {
        [_dbObj createTable];
    }
    
    [[self mapView] setShowsUserLocation:YES];
    
    [[self locationManager] setDelegate:self];
    
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    [[self locationManager] startUpdatingLocation];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    static NSDate *previous;
    static int run = 0;
    
    CLLocation *location = locations.lastObject;
    
    if (run == 0 || [location.timestamp timeIntervalSinceDate:previous] > 10)
    {
        [_dbObj insert: location.coordinate.latitude : location.coordinate.longitude : [NSDate date] : location.timestamp];
        
        previous = location.timestamp;
        
        run++;
    }
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2*1609.34, 2*1609.34);
    
    [[self mapView] setRegion:viewRegion animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
