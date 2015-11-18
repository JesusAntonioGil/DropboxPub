//
//  DPBDropboxManager.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBDropboxManager.h"

#import <DropboxSDK/DropboxSDK.h>


@implementation DPBDropboxManager

+ (DPBDropboxManager *)shared
{
    static DPBDropboxManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DPBDropboxManager alloc] init];
    });
    
    return instance;
}

#pragma mark - PUBLIC
#pragma mark - Configure

- (void)initDropboxSession
{
    DBSession *dbSession = [[DBSession alloc] initWithAppKey:DPBDropbpxAppKey appSecret:DPBDropboxAppSecret root:kDBRootAppFolder];
    [DBSession setSharedSession:dbSession];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [[DBSession sharedSession] handleOpenURL:url];
}

#pragma mark - Login

- (BOOL)dropboxIsLinked
{
    return [[DBSession sharedSession] isLinked];
}

- (void)dropboxLinkFromController:(UIViewController *)viewController
{
    [[DBSession sharedSession] linkFromController:viewController];
}

- (void)dropboxUnlinkedAll
{
    [[DBSession sharedSession] unlinkAll];
}

@end
