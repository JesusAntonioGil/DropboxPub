//
//  DPBEpubLibraryCollectionViewCell.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubLibraryCollectionViewCell.h"


@interface DPBEpubLibraryCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameFileLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateFileLabel;

@end


@implementation DPBEpubLibraryCollectionViewCell

#pragma mark - ACCESSORS

- (void)setMetadata:(DBMetadata *)metadata
{
    _metadata = metadata;
    [self customizeMetadataCell];
}

#pragma mark - PRIVATE

- (void)customizeMetadataCell
{
    if(self.metadata.isDirectory) self.iconImageView.image = [UIImage imageNamed:@"folder_icon"];else self.iconImageView.image = [UIImage imageNamed:@"epub_icon"];
    
    self.nameFileLabel.text = self.metadata.filename;
    self.dateFileLabel.text = [self.metadata.lastModifiedDate stringDateWithFormat:@"dd/MM/yyyy hh:mm"];
}

@end
