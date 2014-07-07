//
//  ADLivelyTableView.h
//  ADLivelyTableView
//
//  Created by Romain Goyet on 18/04/12.
//  Copyright (c) 2012 Applidium. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSTimeInterval ADLivelyDefaultDuration;
typedef NSTimeInterval (^ADLivelyTransform)(CALayer * layer, float speed);

extern ADLivelyTransform ADLivelyTransformFade;

@interface ADLivelyTableView : UICollectionView <UICollectionViewDelegate> {
    id <UICollectionViewDelegate>  _preLivelyDelegate;
    CGPoint _lastScrollPosition;
    CGPoint _currentScrollPosition;
    ADLivelyTransform _transformBlock;
}
- (CGPoint)scrollSpeed;
- (void)setInitialCellTransformBlock:(ADLivelyTransform)block;
@end
