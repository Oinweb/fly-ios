//
//  MSICustomNavigationController.h
//  eCantina POS
//
//  Created by Bartlomiej Mika on 2015-07-28.
//  Copyright (c) 2015 Bartlomiej Mika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OINCustomNavigationController : UINavigationController

@property (nonatomic) OINReachability *internetReachability;
@property(nonatomic, weak)id receipt;

@end
