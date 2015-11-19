//
//  DPBEpubLibraryViewController.h
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, DPBFileOrder){
    DPBFileOrderByName      = 0,
    DPBFileOrderByDate      = 1
};

typedef NS_ENUM(NSUInteger, DPBFileShowType){
    DPBFileShowTypeTable      = 0,
    DPBFileShowTypeCollection = 1
};


@interface DPBEpubLibraryViewController : UIViewController

@property (strong, nonatomic) NSString *pathDirectory;
@property (assign, nonatomic) DPBFileOrder fileOrder;
@property (assign, nonatomic) DPBFileShowType fileShowType;

@end
