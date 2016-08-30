//
//  OINNoInternetWarningTableViewController.m
//  BizMula Goals
//
//  Created by Bartlomiej Mika on 2014-09-16.
//  Copyright (c) 2014 Reimar Group. All rights reserved.
//

#import "OINNoInternetConnectivityTableViewController.h"

@interface OINNoInternetConnectivityTableViewController ()
@property (nonatomic) OINReachability *internetReachability;
@end

@implementation OINNoInternetConnectivityTableViewController

#pragma mark - OINReachability Methods -
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
    if ([self isBeingDismissed]) { // DC: Prevent double calls to function.
        return;
    }
    
    if (reachability == self.internetReachability)
	{
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        BOOL isInternetReachable = (netStatus != NotReachable);
        
        if (isInternetReachable) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        if (isInternetReachable) {
            NSLog(@"INTERNET IS AVAILABLE");
        }
	}
}

#pragma mark - UIViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the method reachabilityChanged will be called.
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    // Turn on reachability detector.
    self.internetReachability = [OINReachability reachabilityForInternetConnection];
	[self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    _internetReachability = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kReachabilityChangedNotification object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    UIImage *image = [UIImage imageNamed:@"WifiFull"];
    cell.imageView.image = image;
    cell.textLabel.text = @"No Internet Connectivity";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 * Looks inside our section and sees what header string to use.
 */
- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    return @"ERROR";
}

/**
 * Looks inside our section and sees what footer string to use.
 */
- (NSString *)tableView:(UITableView *)tableView
titleForFooterInSection:(NSInteger)section {
    
    return @"No connection to the internet was detected through Cellular or Wifi. Please connect to the internet and this error will immediately dissapear.";
}

@end
