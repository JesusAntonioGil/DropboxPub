//
//  DPBEpubLibraryPresenter.h
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DPBEpubLibraryPresenterDelegate <NSObject>

@end


@interface DPBEpubLibraryPresenter : NSObject

- (instancetype)initWithViewController:(UIViewController<DPBEpubLibraryPresenterDelegate> *)viewController;
- (void)viewIsReady;
- (void)logoutDropboxAccount;

@end
