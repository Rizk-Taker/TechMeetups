//
//  TNDViewController.m
//  TechMeetups
//
//  Created by Nicolas Rizk on 5/7/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import "TNDViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <INTULocationManager/INTULocationManager.h>
#import "TNDDetailViewController.h"
#import "TNDDataStore.h"
#import "TNDMeetup.h"

@interface TNDViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate>


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
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);

    self.searchBar.delegate = self;
    self.searchBar.text = @"Technology";

    
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
                                       timeout:10.0
                          delayUntilAuthorized:YES  // This parameter is optional, defaults to NO if omitted
                                         block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                             if (status == INTULocationStatusSuccess) {
                                                 // Request succeeded, meaning achievedAccuracy is at least the requested accuracy, and
                                                 // currentLocation contains the device's current location.
                                                 self.lat = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
                                                 
                                                 self.lon = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
                                                 self.dataStore = [TNDDataStore sharedDataStore];
                                                 
                                                 [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                                 
                                                 [self.dataStore getMeetUpsAroundUserLocationWithLatitude:self.lat
                                                                                             andLongitude:self.lon
                                                                                                 ForTopic:self.searchBar.text
                                                                                          CompletionBlock:^{
                                                                                              if ([self.dataStore.meetUps count] > 0) {
                                                                                                  [self.tableView reloadData];
                                                                                              } else {
                                                                                                  [self showAlertWithMessage:@"No results found for this topic"];
                                                                                              }
                                                                                              
                                                                                              
                                                                                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                                                              
                                                                                          }];
                                             }
                                             else if (status == INTULocationStatusTimedOut) {
                                                 // Wasn't able to locate the user with the requested accuracy within the timeout interval.
                                                 // However, currentLocation contains the best location available (if any) as of right now,
                                                 // and achievedAccuracy has info on the accuracy/recency of the location in currentLocation.
                                                 [self showAlertWithMessage:@"Request has timed out. Please try again."];
                                             }
                                             else {
                                                 // An error occurred, more info is available by looking at the specific status returned.
                                                 [self showAlertWithMessage:@"Could not get your current location. Please try again."];
                                             }
                                         }];


}

- (void)viewWillAppear:(BOOL)animated {
    UINavigationBar *navBar = self.navigationController.navigationBar;
//    UIImage *image = [UIImage imageNamed:@"meetUpLogo"];
    [navBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"redBackground"]]];
    self.navigationItem.title = @"Meetup";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Avenir" size:30], NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
}

- (void) showAlertWithMessage:(NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *popVC = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertController addAction:popVC];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0) {
        self.dataStore.meetUps = [[NSMutableArray alloc] init];
        [self.tableView reloadData];
    }
}


#pragma mark - Table View Configuration

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataStore.meetUps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    TNDMeetup *meetUp = self.dataStore.meetUps[indexPath.row];


        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    [cell setBackgroundColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"redBackground"]]];
    
    cell.textLabel.text = meetUp.eventName;
    NSInteger spotsAvailable = [meetUp.attendeeLimit integerValue] - [meetUp.rsvpCount integerValue];

   
    NSString *subOfsubtitle;
    
    if (spotsAvailable <= 0) {
        subOfsubtitle = @"This meeting is full";
    } else {
        subOfsubtitle = [NSString stringWithFormat:@"%ld spots left!", spotsAvailable];
    }
    
    NSString *subtitle = [NSString stringWithFormat:@"\n%@\nAttending: %@ %@ - %@", meetUp.meetupName, meetUp.rsvpCount, meetUp.typeOfAttendee, subOfsubtitle];
    
    
    cell.detailTextLabel.text = subtitle;
    
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self.dataStore getMeetUpsAroundUserLocationWithLatitude:self.lat
                                                andLongitude:self.lon
                                                    ForTopic:self.searchBar.text
                                             CompletionBlock:^{
                                                 
                                                 [self.tableView reloadData];
                                                 
                                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                 
                                             }];
    
    [searchBar resignFirstResponder];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    
    TNDDetailViewController *detailVC = segue.destinationViewController;
    
    NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
    
    detailVC.meetUp = self.dataStore.meetUps[ip.row];
    
    
}



@end
