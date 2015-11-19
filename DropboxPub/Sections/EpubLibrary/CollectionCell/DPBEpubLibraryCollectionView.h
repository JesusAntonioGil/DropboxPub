//
//  DPBEpubLibraryCollectionView.h
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DBMetadata.h>


@protocol DPBEpubLibraryCollectionViewDelegate <NSObject>

- (void)didSelectMetadata:(DBMetadata *)metadata;

@end


@interface DPBEpubLibraryCollectionView : UICollectionView

@property (strong, nonatomic) NSArray *files;
@property (assign, nonatomic) id<DPBEpubLibraryCollectionViewDelegate> epubLibraryCollectionViewDelegate;

@end
