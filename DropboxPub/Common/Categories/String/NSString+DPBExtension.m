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
    NSArray *components = [self componentsSeparatedByString:@"."];
    return components.lastObject;
}

@end
