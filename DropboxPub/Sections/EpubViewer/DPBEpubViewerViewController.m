//
//  DPBEpubViewerViewController.m
//  DropboxPub
//
//  Created by Jesus Antonio Gil on 19/11/15.
//  Copyright © 2015 Jesus Antonio Gil. All rights reserved.
//

#import "DPBEpubViewerViewController.h"
#import "DPBEpubViewerPresenter.h"

#import <KFEpubKit/KFEpubController.h>
#import <KFEpubContentModel.h>


@interface DPBEpubViewerViewController () <DPBEpubViewerPresenterDelegate , KFEpubControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) DPBEpubViewerPresenter *presenter;
@property (strong, nonatomic) KFEpubController *epubController;
@property (strong, nonatomic) KFEpubContentModel *epubContentModel;
@property (assign, nonatomic) NSUInteger spineIndex;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end


@implementation DPBEpubViewerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    rightSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    rightSwipeRecognizer.delegate = self;
    [self.webView addGestureRecognizer:rightSwipeRecognizer];
    
    UISwipeGestureRecognizer *leftSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
    leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    leftSwipeRecognizer.delegate = self;
    [self.webView addGestureRecognizer:leftSwipeRecognizer];
    
    self.presenter = [[DPBEpubViewerPresenter alloc] initWithViewController:self];
    [self.presenter downloadFileWithMetadata:self.metadata];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - ACCESSORS

- (IBAction)onCloseButtonTap:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PRIVATE

- (void)createEpubControllerWithLocalPath:(NSString *)localPath
{
    NSURL *epubURL = [NSURL fileURLWithPath:localPath];
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    self.epubController = [[KFEpubController alloc] initWithEpubURL:epubURL andDestinationFolder:documentsURL];
    self.epubController.delegate = self;
    [self.epubController openAsynchronous:YES];
}

#pragma mark - Gestures

- (void)didSwipeRight:(UIGestureRecognizer *)recognizer
{
    if (self.spineIndex > 1)
    {
        self.spineIndex--;
        [self updateContentForSpineIndex:self.spineIndex];
    }
}


- (void)didSwipeLeft:(UIGestureRecognizer *)recognizer
{
    if (self.spineIndex < self.epubContentModel.spine.count)
    {
        self.spineIndex++;
        [self updateContentForSpineIndex:self.spineIndex];
    }
}

#pragma mark - Epub content

- (void)updateContentForSpineIndex:(NSUInteger)currentSpineIndex
{
    NSString *contentFile = self.epubContentModel.manifest[self.epubContentModel.spine[currentSpineIndex]][@"href"];
    NSURL *contentURL = [self.epubController.epubContentBaseURL URLByAppendingPathComponent:contentFile];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:contentURL];
    [self.webView loadRequest:request];
}

#pragma mark - PROTOCOLS & DELEGATES
#pragma mark - Presenter Delegate

- (void)presenterDownloadEpubWithPath:(NSString *)localPath contentType:(NSString *)contentType metadata:(DBMetadata *)metadata error:(NSError *)error
{
    if(!error)
    {
        self.metadata = metadata;
        [self createEpubControllerWithLocalPath:localPath];
    }
    else
    {
        [[DPBAlert defaultAlert] alert:error.description viewController:self];
    }
}

#pragma mark KFEpubControllerDelegate Delegate

- (void)epubController:(KFEpubController *)controller didOpenEpub:(KFEpubContentModel *)contentModel
{
    self.epubContentModel = contentModel;
    self.spineIndex = 1;
    [self updateContentForSpineIndex:self.spineIndex];
}


- (void)epubController:(KFEpubController *)controller didFailWithError:(NSError *)error
{
    [[DPBAlert defaultAlert] alert:error.description viewController:self];
}

#pragma mark - UIGestureRecognizer Delegate


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
