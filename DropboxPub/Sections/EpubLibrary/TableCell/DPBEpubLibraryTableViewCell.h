//
//  DPBEpubLibraryTableViewCell.h
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 18/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DBMetadata.h>


@interface DPBEpubLibraryTableViewCell : UITableViewCell

@property (strong, nonatomic) DBMetadata *metadata;

@end
