//
//  NSString+DPBExtension.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "NSString+DPBExtension.h"


@implementation NSString (DPBExtension)

- (NSString *)getExtensionFileName
{
    NSString *folderName = [self getFolderName];
    
    NSArray *components = [folderName componentsSeparatedByString:@"."];
    return components.lastObject;
}

- (NSString *)getFolderName
{
    NSArray *components = [self componentsSeparatedByString:@"/"];
    if([components.lastObject isEqualToString:@""])
        return @"Root";
    return components.lastObject;
}

@end
