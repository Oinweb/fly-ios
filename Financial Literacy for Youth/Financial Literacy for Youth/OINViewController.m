//
//  ViewController.m
//  Financial Literacy for Youth
//
//  Created by Bartlomiej Mika on 2016-08-30.
//  Copyright © 2016 Bartlomiej Mika. All rights reserved.
//

#import "OINViewController.h"

@interface OINViewController ()

@end

@implementation OINViewController


/**
 *  Function will ensure no status bar is loaded.
 */
- (BOOL)prefersStatusBarHidden {
    
    return YES;
}


/**
 *  Entry point into our application.
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Get the URL of the application depending on what was set in the "OINMacrosAndConstants.h" file.
    NSDictionary *plist = [NSDictionary oin_propertyListForFileName:OIN_SETTINGS_FILENAME];
    NSURL *aURL = [NSURL URLWithString:[plist objectForKey:@"url"]];
    
    // Fetch the page and load up the UIWebView.
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:aURL];
    [_webView loadRequest:requestObj];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
