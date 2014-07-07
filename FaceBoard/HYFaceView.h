//
//  HYFaceView.h
//  FaceBoard
//
//  Created by 邱扬 on 14-4-8.
//  Copyright (c) 2014年 邱扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYFacialView.h"

//主键盘的高宽
#define HY_BOARD_H 216
#define HY_BOARD_W 320
//表情区
#define HY_FACIAL_H 130
#define HY_FACIAL_W 300
#define HY_FACIAL_X 10
#define HY_FACIAL_Y 15
//键盘底部view
#define HY_BOTTOMVIEW_W 320
#define HY_BOTTOMVIEW_H 40
//键盘页数
#define HY_MAINPAGE_NUM 9
//底部button页数
#define HY_BOTTOMPAGE_NUM 9

//颜色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@protocol HYFaceViewDelegate <NSObject>

- (void)selectedFace:(NSString*)str;

@end

@interface HYFaceView : UIView<UIScrollViewDelegate, HYFacialViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;//表情滚动视图
@property (nonatomic, retain) UIPageControl *pageControl;

@property (nonatomic, retain) UIScrollView *bottomView;  //底部view
@property (nonatomic, retain) UIButton  *preBtn; //上一个button

@property (nonatomic, retain) id<HYFaceViewDelegate> delegate;

@end
