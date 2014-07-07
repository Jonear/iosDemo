//
//  AllImageViewController.h
//  WallPaper
//
//  Created by 余成海 on 13-8-19.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NADAllImageViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;

@property (strong, nonatomic) NSMutableArray *imageArray;
@end
