//
//  locationDisplayViewController.m
//  Loc-Final
//
//  Created by Nickolas McDaniels on 6/26/16.
//  Copyright © 2016 Nickolas Donnell. All rights reserved.
//

#import "locationDisplayViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Contacts/Contacts.h>
@interface locationDisplayViewController ()

@end

@implementation locationDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dateField.enabled = NO;
    self.timeField.enabled = NO;
    
    NSString *subtitle = [[NSString alloc] init];
    
    [self.dateField setText:[_locationRecord valueForKey:@"date"]];
    
    [self.timeField setText:[_locationRecord valueForKey:@"time"]];
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[[_locationRecord valueForKey:@"latitude"] floatValue] longitude:[[_locationRecord valueForKey:@"longitude"] floatValue]];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *err)
     {
         NSLog(@"GOT IN");
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         
         NSArray *lines = [placemark.addressDictionary valueForKey:@"FormattedLineAddress"];
         for (int i = 0; i<lines.count; i++) {
             [subtitle stringByAppendingString:[lines objectAtIndex:i]];
         }
     }];
    
    CLLocationCoordinate2D center;
    
    center.latitude = [[_locationRecord valueForKey:@"latitude"] floatValue];
    center.longitude = [[_locationRecord valueForKey:@"longitude"] floatValue];
    
    _currentAnnotation = [[MKPointAnnotation alloc] init];
    
    _currentAnnotation.coordinate = center;
    _currentAnnotation.title = [NSString stringWithFormat:@"lat: %.3f lon: %.3f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
    _currentAnnotation.subtitle = subtitle;
    
    [self.mapView addAnnotation:_currentAnnotation];
    [self.mapView selectAnnotation:_currentAnnotation animated:YES];
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:_currentAnnotation.coordinate fromEyeCoordinate:CLLocationCoordinate2DMake(_currentAnnotation.coordinate.latitude, _currentAnnotation.coordinate.longitude) eyeAltitude:10000];
    [self.mapView setCamera:camera animated:YES];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationRecord = [[NSMutableDictionary alloc] init];
        [_locationRecord removeAllObjects];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
