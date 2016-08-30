//
//  NSDictionary+OINPropertyList.m
//  Financial Literacy for Youth
//
//  Created by Bartlomiej Mika on 2016-08-30.
//  Copyright © 2016 Bartlomiej Mika. All rights reserved.
//

#import "NSDictionary+OINPropertyList.h"

@implementation NSDictionary (OINPropertyList)

+(NSDictionary *)oin_propertyListForFileName: (NSString *)fileName
{
    NSData *plistData;
    NSError *error;
    NSPropertyListFormat plistFormat;
    id plist;
    
    NSString *localizedPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    plistData = [NSData dataWithContentsOfFile:localizedPath];
    //NSData * plistData = [[NSData alloc] initWithContentsOfFile:@"Data.plist"];
    
    
    plist = [NSPropertyListSerialization propertyListWithData:plistData
                                                      options:NSPropertyListImmutable
                                                       format:&plistFormat
                                                        error:&error];
    if (!plist) {
        NSLog(@"Error reading plist from file '%s', error = '%@'", [localizedPath UTF8String], error);
        return nil;
    }
    
    return plist;
}

@end
