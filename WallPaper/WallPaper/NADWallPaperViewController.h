//
//  ViewController.h
//  WallPaper
//
//  Created by 余成海 on 13-8-13.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NADWallPaperViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;

@property (strong, nonatomic) NSMutableArray *imageArray;

@property (nonatomic) int animationCount;

@end
