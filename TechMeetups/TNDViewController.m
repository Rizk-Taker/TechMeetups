//
//  TNDViewController.m
//  TechMeetups
//
//  Created by Nicolas Rizk on 5/7/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import "TNDViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "TNDDataStore.h"
#import "TNDMeetup.h"

@interface TNDViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) TNDDataStore *dataStore;
@end

@implementation TNDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    self.searchBar.text = @"technology";
    self.locationManager = [[CLLocationManager alloc] init];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.lat = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
    
    self.lon = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
    self.dataStore = [TNDDataStore sharedDataStore];
    
//    [self.dataStore getMeetUpsAroundUserLocationWithLatitude:self.lat andLongitude:self.lon ForTopic:self.searchBar.text];
//    [self.tableView reloadData];
}

#pragma mark - Table View Configuration

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataStore.meetUps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView = self.tableView;
    
    static NSString *cellIdentifier = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    TNDMeetup *meetUp = self.dataStore.meetUps[indexPath.row];
    
    cell.textLabel.text = meetUp.eventName;

    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSIndexPath *ip = [tableView indexPathForSelectedRow];
//    
//}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
      [self.dataStore getMeetUpsAroundUserLocationWithLatitude:self.lat andLongitude:self.lon ForTopic:self.searchBar.text];
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
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
