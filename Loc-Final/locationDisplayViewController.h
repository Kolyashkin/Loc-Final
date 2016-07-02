//
//  locationDisplayViewController.h
//  Loc-Final
//
//  Created by Nickolas McDaniels on 6/26/16.
//  Copyright © 2016 Nickolas Donnell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface locationDisplayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableDictionary *locationRecord;
@property (strong, nonatomic) MKPointAnnotation *currentAnnotation;

@end
