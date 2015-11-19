//
//  DPBAlert.h
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DPBAlert : NSObject

+ (instancetype)defaultAlert;

- (void)alert:(NSString *)message viewController:(UIViewController *)viewController;

@end
