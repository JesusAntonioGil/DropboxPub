//
//  DPBEpubLibraryTableView.h
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DBMetadata.h>


@protocol DPBEpubLibraryTableViewDelegate <NSObject>

- (void)didSelectMetadata:(DBMetadata *)metadata;

@end


@interface DPBEpubLibraryTableView : UITableView

@property (strong, nonatomic) NSArray *files;
@property (assign, nonatomic) id<DPBEpubLibraryTableViewDelegate> epubLibraryTableViewDelegate;

@end
