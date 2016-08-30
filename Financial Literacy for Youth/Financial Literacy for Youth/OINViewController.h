//
//  ViewController.h
//  Financial Literacy for Youth
//
//  Created by Bartlomiej Mika on 2016-08-30.
//  Copyright © 2016 Bartlomiej Mika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OINViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

