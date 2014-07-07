//
//  PhotoViewController.h
//  WallPaper
//
//  Created by 余成海 on 13-8-14.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FAFancyButton.h"
#import "NADFancyMenu.h"

@interface NADPhotoViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, NADFancyMenuDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;

@property (strong, nonatomic) NSMutableArray *fancybuttons;
@property (nonatomic) BOOL isShowButton;
@property (nonatomic) BOOL isShowing;
@property (nonatomic) BOOL isPreview;
@property (nonatomic) CGSize buttonSize;
@property (nonatomic) float buttonCount;

@property (strong, nonatomic) UIImageView *preview;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) NSMutableArray *imageLoading;

@property (strong, nonatomic) NADFancyMenu *fancymenu;

- (IBAction)touchtap:(UITapGestureRecognizer *)sender;


@end
