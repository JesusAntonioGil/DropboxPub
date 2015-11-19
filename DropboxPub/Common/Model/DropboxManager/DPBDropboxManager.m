//
//  DPBDropboxManager.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBDropboxManager.h"

#import <DropboxSDK/DropboxSDK.h>


@interface DPBDropboxManager  () <DBRestClientDelegate>

@property (strong, nonatomic) DBRestClient *restClient;
@property (copy, nonatomic) DPBDropboxManagerFilesCompletion completion;

@end


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

#pragma mark - ACCESSORS

- (DBRestClient *)restClient
{
    if(!_restClient)
    {
        _restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        _restClient.delegate = self;
    }
    
    return _restClient;
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
    if([[DBSession sharedSession] handleOpenURL:url])
        if([self dropboxIsLinked]) return YES;
    
    return NO;
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

#pragma mark - Files

- (void)loadFilesWithPathDirectory:(NSString *)pathDirectory completion:(DPBDropboxManagerFilesCompletion)completion
{
    self.completion = completion;
    [self.restClient loadMetadata:pathDirectory];
}

#pragma mark - PROTOCOLS & DELEGATES

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata
{
    NSMutableArray *mutableMetadatas = [NSMutableArray new];
    
    for(DBMetadata *metadataFile in metadata.contents)
    {
        if(metadataFile.isDirectory || [[metadataFile.filename getExtensionFileName] isEqualToString:DPBDropboxFileExtension]) [mutableMetadatas addObject:metadataFile];
    }
    
    self.completion(mutableMetadatas, nil);
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error
{
    self.completion(nil, error);
}

@end
