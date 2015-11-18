//
//  DPBEpubLibraryTableViewCell.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubLibraryTableViewCell.h"


@interface DPBEpubLibraryTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameFileLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateFileLabel;

@end


@implementation DPBEpubLibraryTableViewCell

- (void)awakeFromNib
{

}

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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    self.dateFileLabel.text = [formatter stringFromDate:self.metadata.lastModifiedDate];
}

@end
