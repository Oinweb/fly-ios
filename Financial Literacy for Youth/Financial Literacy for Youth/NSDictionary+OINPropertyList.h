//
//  NSDictionary+OINPropertyList.h
//  Financial Literacy for Youth
//
//  Created by Bartlomiej Mika on 2016-08-30.
//  Copyright © 2016 Bartlomiej Mika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (OINPropertyList)

+(NSDictionary *)oin_propertyListForFileName: (NSString *)fileName;

@end
