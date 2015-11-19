//
//  DPBEpubLibraryPresenter.h
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DPBEpubLibraryViewController.h"


@protocol DPBEpubLibraryPresenterDelegate <NSObject>

- (void)presenterFileList:(NSArray *)files error:(NSError *)error;
- (void)presenterOrderList:(NSInteger)order;

@end


@interface DPBEpubLibraryPresenter : NSObject

@property (strong, nonatomic) NSString *pathDirectory;

- (instancetype)initWithViewController:(UIViewController<DPBEpubLibraryPresenterDelegate> *)viewController;
- (void)viewIsReady;
- (void)logoutDropboxAccount;
- (void)getDropboxFileListFromPathDirectory:(NSString *)pathDirectory;
- (void)showOrderActionController;
- (NSArray *)sortList:(NSArray *)list order:(DPBFileOrder)fileOrder;
- (void)pushEpubLibraryWithPathDirectory:(NSString *)pathDirectory order:(DPBFileOrder)fileOrder showType:(DPBFileShowType)showType;

@end
