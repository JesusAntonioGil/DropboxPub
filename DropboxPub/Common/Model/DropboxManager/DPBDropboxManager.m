//
//  DPBDropboxManager.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBDropboxManager.h"


@interface DPBDropboxManager  () <DBRestClientDelegate>

@property (strong, nonatomic) DBRestClient *restClient;
@property (copy, nonatomic) DPBDropboxManagerFilesCompletion metadataCompletion;
@property (copy, nonatomic) DPBDropboxManagerDownloadFileCompletion downloadCompletion;
@property (strong, nonatomic) NSString *localPath;

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
    self.metadataCompletion = completion;
    [self.restClient loadMetadata:pathDirectory];
}

- (void)downloadFileWithPath:(NSString *)filePath completion:(DPBDropboxManagerDownloadFileCompletion)completion
{
    self.downloadCompletion = completion;
    [self.restClient loadFile:filePath intoPath:[self generateLocalPathWithName:filePath]];
}

#pragma mark - PRIVATE

- (NSString *)generateLocalPathWithName:(NSString *)name
{
    NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [localDir stringByAppendingPathComponent:name];
}

#pragma mark - PROTOCOLS & DELEGATES
#pragma mark - Metadata Delegate

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata
{
    NSMutableArray *mutableMetadatas = [NSMutableArray new];
    
    for(DBMetadata *metadataFile in metadata.contents)
    {
        if(metadataFile.isDirectory || [[metadataFile.filename getExtensionFileName] isEqualToString:DPBDropboxFileExtension]) [mutableMetadatas addObject:metadataFile];
    }
    
    self.metadataCompletion(mutableMetadatas, nil);
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error
{
    self.metadataCompletion(nil, error);
}

#pragma mark - Download Delegate

- (void)restClient:(DBRestClient *)client loadedFile:(NSString *)localPath
       contentType:(NSString *)contentType metadata:(DBMetadata *)metadata
{
    self.downloadCompletion(localPath, contentType, metadata, nil);
}

- (void)restClient:(DBRestClient *)client loadFileFailedWithError:(NSError *)error
{
    self.downloadCompletion(nil, nil, nil, error);
}

@end
