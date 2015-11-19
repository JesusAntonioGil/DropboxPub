//
//  DPBEpubLibraryCollectionView.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubLibraryCollectionView.h"
#import "DPBEpubLibraryCollectionViewCell.h"


@interface DPBEpubLibraryCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>



@end


@implementation DPBEpubLibraryCollectionView

- (void)awakeFromNib
{
    self.delegate = self;
    self.dataSource = self;
    self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
}

#pragma mark - ACCESSORS

- (void)setFiles:(NSArray *)files
{
    _files = files;
    
    [self reloadData];
}

#pragma mark - PROTCOLS & DELEGATES
#pragma mark - UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.files.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DPBEpubLibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DPBEpubLibraryCollectionViewCell" forIndexPath:indexPath];
    
    cell.metadata = self.files[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 150);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DBMetadata *metadata = self.files[indexPath.item];
    [self.epubLibraryCollectionViewDelegate didSelectMetadata:metadata];
    
}


@end
