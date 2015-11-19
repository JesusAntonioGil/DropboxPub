//
//  DPBEpubViewerPresenter.h
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol DPBEpubViewerPresenterDelegate <NSObject>

@end


@interface DPBEpubViewerPresenter : NSObject

- (instancetype)initWithViewController:(UIViewController<DPBEpubViewerPresenterDelegate> *)viewController;
- (void)viewIsReady;

@end
