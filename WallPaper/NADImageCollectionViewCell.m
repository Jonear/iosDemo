//
//  imageCollectionViewCell.m
//  WallPaper
//
//  Created by 余成海 on 13-8-13.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import "NADImageCollectionViewCell.h"

@implementation NADImageCollectionViewCell

@synthesize imageView;
@synthesize title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"NADImageCollectionViewCell" owner:self options: nil];
        if(arrayOfViews.count < 1){return nil;}
        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]){
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        self.isShowCell = NO;
    }
    return self;
}

- (void)setImageWithURL:(NSURL *)url title:(NSString *)name
{
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    
//    // Remove in progress downloader from queue
//    [manager cancelForDelegate:self];
//    
//    UIImage *cachedImage = nil;
//    if (url) {
//        cachedImage = [manager imageWithURL:url];
//    }
//    
//    if (cachedImage) {
//        [self setImage:cachedImage];
//    }
//    else {
//        if (placeholder) {
//            [self setImage:placeholder];
//        }
//        
//        if (url) {
//            [manager downloadWithURL:url delegate:self];
//        }
//    }
    //[imageView setImage:[UIImage imageNamed:@"17.png"]];
    [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
    
    [self.title setText:name];
}
//
//- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image {
//    [self setImage:image];
//}

@end
