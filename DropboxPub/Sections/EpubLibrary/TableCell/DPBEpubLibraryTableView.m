//
//  DPBEpubLibraryTableView.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubLibraryTableView.h"
#import "DPBEpubLibraryTableViewCell.h"


@interface DPBEpubLibraryTableView () <UITableViewDelegate, UITableViewDataSource>

@end


@implementation DPBEpubLibraryTableView

- (void)awakeFromNib
{
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark - ACCESSORS

- (void)setFiles:(NSArray *)files
{
    _files = files;
    
    [self reloadData];
}

#pragma mark - PROTOCOLS & DELEGATES
#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPBEpubLibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DPBEpubLibraryTableViewCell"];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DPBEpubLibraryTableViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    cell.metadata = self.files[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DBMetadata *metadata = self.files[indexPath.row];
    [self.epubLibraryTableViewDelegate didSelectMetadata:metadata];
}

@end
