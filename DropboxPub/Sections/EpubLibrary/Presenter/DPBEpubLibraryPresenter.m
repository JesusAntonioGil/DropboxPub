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
@property (strong, nonatomic) UIAlertController *alertController;

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

#pragma mark - ACCESSORS

- (UIAlertController *)alertController
{
    if(!_alertController)
    {
        _alertController = [UIAlertController alertControllerWithTitle:@"Choose order" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *nameAction = [UIAlertAction actionWithTitle:@"By name" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
        {
            [self.viewController presenterOrderList:DPBFileOrderByName];
        }];
        UIAlertAction *dateAction = [UIAlertAction actionWithTitle:@"By date" style: UIAlertActionStyleDefault handler:^(UIAlertAction * action)
        {
            [self.viewController presenterOrderList:DPBFileOrderByDate];
        }];
        
        [_alertController addAction:nameAction];
        [_alertController addAction:dateAction];
    }
    
    return _alertController;
}

#pragma mark - PUBLIC

- (void)viewIsReady
{
    [self getDropboxFileListFromPathDirectory:self.pathDirectory];
}

#pragma mark - Dropbox

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

#pragma mark - Sort

- (void)showOrderActionController
{
    [self.viewController presentViewController:self.alertController animated:YES completion:nil];
}

- (NSArray *)sortList:(NSArray *)list order:(DPBFileOrder)fileOrder
{
    NSArray *sortDescriptors = [NSArray new];
    
    switch (fileOrder) {
        case DPBFileOrderByName:
            sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"filename" ascending:YES selector:@selector(caseInsensitiveCompare:)]];
            break;
        case DPBFileOrderByDate:
            sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"lastModifiedDate" ascending:YES]];
            break;
        default:
            break;
    }
    
    return [list sortedArrayUsingDescriptors:sortDescriptors];
}

#pragma mark - Directory

- (void)pushEpubLibraryWithPathDirectory:(NSString *)pathDirectory order:(DPBFileOrder)fileOrder showType:(DPBFileShowType)showType
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DPBEpubLibraryViewController *epubLibraryViewController = [storyboard instantiateViewControllerWithIdentifier:@"DPBEpubLibraryViewController"];
    epubLibraryViewController.pathDirectory = pathDirectory;
    epubLibraryViewController.fileOrder = fileOrder;
    epubLibraryViewController.fileShowType = showType;
    [self.viewController.navigationController pushViewController:epubLibraryViewController animated:YES];
}

@end
