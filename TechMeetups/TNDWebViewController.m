//
//  TNDWebViewController.m
//  TechMeetups
//
//  Created by Nicolas Rizk on 5/9/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import "TNDWebViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface TNDWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TNDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self loadWebviewWithString:self.urlString andWebview:self.webView];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebviewWithString:(NSString *)string andWebview:(UIWebView *)webView {
    
    NSString *urlString = string;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
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
