//
//  DPBEpubLibraryPresenter.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubLibraryPresenter.h"
#import "DPBDropboxManager.h"
#import "DPBEpubLibraryViewController.h"


@interface DPBEpubLibraryPresenter ()

@property (strong, nonatomic) UIViewController<DPBEpubLibraryPresenterDelegate> *viewController;

@end


@implementation DPBEpubLibraryPresenter

- (instancetype)initWithViewController:(UIViewController<DPBEpubLibraryPresenterDelegate> *)viewController
{
    self = [super init];
    if(self)
    {
        self.viewController = viewController;
    }
    
    return self;
}

#pragma mark - PUBLIC

- (void)viewIsReady
{
    [self getDropboxFileListFromPathDirectory:self.pathDirectory];
}

- (void)logoutDropboxAccount
{
    [[DPBDropboxManager shared] dropboxUnlinkedAll];
    
    if(![[DPBDropboxManager shared] dropboxIsLinked])
    {
        [self.viewController.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)getDropboxFileListFromPathDirectory:(NSString *)pathDirectory;
{
    __weak typeof(self) weakSelf = self;
    [[DPBDropboxManager shared] loadFilesWithPathDirectory:pathDirectory completion:^(NSArray *files, NSError *error)
    {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.viewController presenterFileList:files error:error];
    }];
}

- (void)pushEpubLibraryWithPathDirectory:(NSString *)pathDirectory
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DPBEpubLibraryViewController *epubLibraryViewController = [storyboard instantiateViewControllerWithIdentifier:@"DPBEpubLibraryViewController"];
    epubLibraryViewController.pathDirectory = pathDirectory;
    [self.viewController.navigationController pushViewController:epubLibraryViewController animated:YES];
}

@end
