//
//  DPBLoginPresenter.h
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DPBLoginPresenterDelegate <NSObject>

- (void)presenterDropboxLinked:(BOOL)linked;

@end


@interface DPBLoginPresenter : NSObject

- (instancetype)initWithViewController:(UIViewController<DPBLoginPresenterDelegate> *)viewController;
- (void)viewIsReady;
- (void)presentDropboxLoginViewController;
- (void)presentEpubLibraryController;

@end
