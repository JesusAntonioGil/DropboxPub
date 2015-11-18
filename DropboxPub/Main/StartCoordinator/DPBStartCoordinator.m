//
//  DPBStartCoordinator.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBStartCoordinator.h"
#import "DPBDropboxManager.h"


@implementation DPBStartCoordinator

#pragma mark - PUBLIC

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Dropbox
    [[DPBDropboxManager shared] initDropboxSession];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return[[DPBDropboxManager shared] handleOpenURL:url];
}

@end
