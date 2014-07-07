//
//  imageCollectionViewCell.h
//  WallPaper
//
//  Created by 余成海 on 13-8-13.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImage/UIImageView+WebCache.h"

@interface NADImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic) BOOL isShowCell;

- (void) setImageWithURL: (NSURL*)url title:(NSString*)name;

@end
