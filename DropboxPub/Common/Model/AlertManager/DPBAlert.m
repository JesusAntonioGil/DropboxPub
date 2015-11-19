//
//  DPBAlert.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBAlert.h"


@implementation DPBAlert

+ (instancetype)defaultAlert
{
    static DPBAlert *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark - PUBLIC

- (void)alert:(NSString *)message viewController:(UIViewController *)viewController
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:DPBAppName message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *acceptAction = [UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {
                                     [alertView dismissViewControllerAnimated:YES completion:nil];
                                 }];
    [alertView addAction:acceptAction];
    [viewController presentViewController:alertView animated:YES completion:nil];
}

@end
