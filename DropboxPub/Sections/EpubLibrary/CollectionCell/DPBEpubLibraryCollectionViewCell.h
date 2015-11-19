//
//  DPBEpubLibraryCollectionViewCell.h
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DBMetadata.h>


@interface DPBEpubLibraryCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) DBMetadata *metadata;

@end
