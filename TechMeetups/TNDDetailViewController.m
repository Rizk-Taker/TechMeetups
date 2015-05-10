//
//  TNDDetailViewController.m
//  TechMeetups
//
//  Created by Nicolas Rizk on 5/9/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import "TNDDetailViewController.h"
#import "TNDWebViewController.h"
#import "TNDMapViewController.h"

@interface TNDDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *eventNameTextView;
@property (weak, nonatomic) IBOutlet UILabel *meetupNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;

@end


@implementation TNDDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"redDetailBackground"]]];
    
    NSString *meetUpNamePresents = [NSString stringWithFormat:@"%@ presents", self.meetUp.meetupName];
    
    [self.meetupNameLabel setText:meetUpNamePresents];
    
    NSArray *textViews = @[self.eventNameTextView,
                           self.descriptionTextView,
                           self.addressTextView];
    
    NSMutableAttributedString *eventURLString = [[NSMutableAttributedString alloc] initWithString:self.meetUp.eventName];
    
    [self.eventNameTextView setAttributedText:eventURLString];
    [self.eventNameTextView setTextAlignment:NSTextAlignmentCenter];
    
    [self.descriptionTextView setAttributedText:self.meetUp.eventDescription];
    self.descriptionTextView.tintColor = [UIColor whiteColor];
    self.descriptionTextView.contentInset = UIEdgeInsetsMake(0,-4,0,0);
    [self.addressTextView setText:self.meetUp.address];
    
    CGFloat fontSize;
    
    for (UITextView *textView in textViews) {
        [textView setBackgroundColor:[UIColor clearColor]];
        [textView setTextColor:[UIColor whiteColor]];
        
        if (textView == self.eventNameTextView) {
            fontSize = 30;
        }
        else {
            fontSize = 15;
        }
        
        [textView setFont:[UIFont fontWithName:@"Avenir" size:fontSize]];
    }
    
    [self.dateLabel setText:self.meetUp.time];
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"mySegue"]) {
        
        TNDWebViewController *webVC = segue.destinationViewController;
        webVC.urlString = self.meetUp.url;
   
    } else if ([segue.identifier isEqualToString:@"mapSegue"]) {
        
        TNDMapViewController *mapVC = segue.destinationViewController;
        mapVC.lat = self.meetUp.lat;
        mapVC.lon = self.meetUp.lon;
        mapVC.address = self.meetUp.address;
    }
}

@end
