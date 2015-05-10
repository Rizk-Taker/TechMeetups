//
//  TNDMapViewController.m
//  TechMeetups
//
//  Created by Nicolas Rizk on 5/9/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import "TNDMapViewController.h"
#import <MapKit/MapKit.h>

@interface TNDMapViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation TNDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.locationManager = [[CLLocationManager alloc] init];
    // Do any additional setup after loading the view.

    
    CGFloat latFloat = [self.lat doubleValue];
    CGFloat lonFloat = [self.lon doubleValue];
    
    CLLocationCoordinate2D locationCoordinate;
    locationCoordinate.latitude = latFloat;
    locationCoordinate.longitude = lonFloat;
    
    MKCoordinateSpan mySpan = MKCoordinateSpanMake(.02, .02);
    MKCoordinateRegion myRegion = MKCoordinateRegionMake(locationCoordinate, mySpan);
    [self.mapView setRegion:myRegion animated:YES];
    self.mapView.showsUserLocation = YES;
    
    MKPointAnnotation *locationAnnotation = [[MKPointAnnotation alloc] init];
    locationAnnotation.coordinate = locationCoordinate;
    locationAnnotation.title = self.address;
    [self.mapView addAnnotation: locationAnnotation];
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
