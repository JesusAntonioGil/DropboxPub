//
//  DPBStartCoordinator.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBStartCoordinator.h"

#import <DropboxSDK/DropboxSDK.h>


@implementation DPBStartCoordinator

#pragma mark - PUBLIC

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Dropbox
    DBSession *dbSession = [[DBSession alloc] initWithAppKey:DPBDropbpxAppKey appSecret:DPBDropboxAppSecret root:kDBRootAppFolder];
    [DBSession setSharedSession:dbSession];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    if ([[DBSession sharedSession] handleOpenURL:url])
    {
        if ([[DBSession sharedSession] isLinked])
        {
            NSLog(@"App linked successfully!");
        }
        
        return YES;
    }
    
    return NO;
}

@end
