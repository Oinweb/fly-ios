//
//  ViewController.m
//  Financial Literacy for Youth
//
//  Created by Bartlomiej Mika on 2016-08-30.
//  Copyright © 2016 Bartlomiej Mika. All rights reserved.
//

#import "OINViewController.h"

@interface OINViewController ()

@property (nonatomic, strong) NSDictionary *plist;

@end

@implementation OINViewController


/**
 *  Lazy instantiation of loading the plist of our application.
 */
- (NSDictionary*)plist {
    if (_plist) {
        return _plist;
    }
    
    // Get the plist of the application depending on what was set in the "OINMacrosAndConstants.h" file.
    _plist = [NSDictionary oin_propertyListForFileName:OIN_SETTINGS_FILENAME];
    return _plist;
}


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
    NSURL *aURL = [NSURL URLWithString:[self.plist objectForKey:@"url"]];
    
    // Fetch the page and load up the UIWebView.
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:aURL];
    [_webView loadRequest:requestObj];
    
    // Attach the UIWebView delegate to our controller so are able to
    // perform various operations on links used.
    [_webView setDelegate: self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Override the code which will evaluate every time a new page is requested
 *  to detect if the User clicked an external link or not. If external link
 *  was clicked then we will load up that page in Apple Safari, else keep
 *  the link inside our UIWebView.
 */
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    // The variables used for our checking.
    NSURL *aURL = [request URL];
    NSURL *aBaseUrl = [NSURL URLWithString:[self.plist objectForKey:@"base_url"]];
    
    // Detect if this UI event was caused by a User "click" in HTML.
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        if ([[aURL absoluteString] containsString: [aBaseUrl absoluteString]] == NO) {
            // The following code will cause the requested link to be loaded
            // up externally in Safari.
            [[UIApplication sharedApplication] openURL:request.URL];
            return NO;
        }
    }
    return YES; // Note: This will cause the link to be loaded internally in UIWebView.
}



@end
