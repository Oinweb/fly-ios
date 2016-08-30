//
//  MSICustomNavigationController.m
//  eCantina POS
//
//  Created by Bartlomiej Mika on 2015-07-28.
//  Copyright (c) 2015 Bartlomiej Mika. All rights reserved.
//

#import "OINCustomNavigationController.h"

@interface OINCustomNavigationController ()

@end

@implementation OINCustomNavigationController

#pragma mark - BBPReachability Methods -

/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
    OINReachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[OINReachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

/*
 * If function detects no internet, it will load up a model view telling the
 * user that this app requires internet connection to continue.
 */
- (void)updateInterfaceWithReachability:(OINReachability *)reachability
{
    if (reachability == self.internetReachability)
    {
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        BOOL isInternetReachable = (netStatus != NotReachable);
        
        if (!isInternetReachable) {
            UINavigationController *svc =
            [self.storyboard instantiateViewControllerWithIdentifier:@"NoInternetConnectionNav"];
            
            [svc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            
            [self presentViewController:svc animated:YES completion:nil];
        }
        
        if (isInternetReachable) {
            NSLog(@"INTERNET IS AVAILABLE");
        }
    }
}

#pragma mark - NavigationalController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /*
     Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the method reachabilityChanged will be called.
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    // Turn on reachability detector.
    self.internetReachability = [OINReachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kReachabilityChangedNotification object:nil];
    
    [super viewWillDisappear:animated];
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
