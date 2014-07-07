//
//  HYFaceView.m
//  FaceBoard
//
//  Created by 邱扬 on 14-4-8.
//  Copyright (c) 2014年 邱扬. All rights reserved.
//

#import "HYFaceView.h"


@implementation HYFaceView

- (id)initWithFrame:(CGRect)frame
{
    //键盘高度216
    self = [super initWithFrame:CGRectMake(0, 0, HY_BOARD_W, HY_BOARD_H)];
    //self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSUserDefaults *defPage = [NSUserDefaults standardUserDefaults];
        [defPage setInteger:0 forKey:@"currentPage"];
        [defPage synchronize];
        _preBtn = [[UIButton alloc] init];
        [self createScrollView];
        [self createPageControl];
        [self createBottomView];
    }
    return self;
}

//创建pagecontrol
- (void)createPageControl {
    //添加pageControl
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(110, HY_FACIAL_H + 20, 100, 20)];
    _pageControl.currentPage = 0;
    //颜色
    _pageControl.pageIndicatorTintColor=RGBACOLOR(195, 179, 163, 1);
    _pageControl.currentPageIndicatorTintColor=RGBACOLOR(132, 104, 77, 1);
    _pageControl.numberOfPages = 9;
    [self addSubview:_pageControl];
}

//创建scrollview
- (void)createScrollView {
    //创建表情键盘
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, HY_BOARD_W, HY_BOARD_H)];
        [_scrollView setBackgroundColor:[UIColor clearColor]];
        for (int i=0; i<9; i++) {
            HYFacialView *fview=[[HYFacialView alloc] initWithFrame:CGRectMake(HY_FACIAL_X+HY_BOARD_W*i, HY_FACIAL_Y, HY_FACIAL_W, HY_FACIAL_H)];
            [fview setBackgroundColor:[UIColor clearColor]];
            [fview loadFacialView:i size:CGSizeMake(43, 43)];
            fview.delegate=self;
            [_scrollView addSubview:fview];
        }
    }
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    _scrollView.contentSize=CGSizeMake(HY_BOARD_W*HY_MAINPAGE_NUM, HY_BOARD_H);
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    [self addSubview:_scrollView];
}

#pragma mark  可以根据不同button显示不同的表情键盘
//创建bottonview
- (void)createBottomView {
    _bottomView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HY_BOARD_H - HY_BOTTOMVIEW_H, HY_BOTTOMVIEW_W, HY_BOTTOMVIEW_H)];
    _bottomView.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < HY_BOTTOMPAGE_NUM; ++i) {
        UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * (HY_BOTTOMVIEW_H + 1), 0, HY_BOTTOMVIEW_H, HY_BOTTOMVIEW_H)];
        bottomBtn.backgroundColor = [UIColor grayColor];
        [bottomBtn setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
        [bottomBtn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
        bottomBtn.tag = i;
        [_bottomView addSubview:bottomBtn];
    }
    [_bottomView setShowsVerticalScrollIndicator:NO];
    [_bottomView setShowsHorizontalScrollIndicator:NO];
    _bottomView.delegate = self;
    _bottomView.pagingEnabled = YES;
    _bottomView.contentSize=CGSizeMake(HY_BOTTOMVIEW_H*HY_BOTTOMPAGE_NUM, HY_BOTTOMVIEW_H);
    [self addSubview:_bottomView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)selectedBtn:(UIButton*)btn {
    _pageControl.currentPage = btn.tag;
    [_scrollView setContentOffset:CGPointMake((btn.tag) * HY_BOARD_W, 0) animated:YES];
    [_preBtn setBackgroundColor:[UIColor grayColor]];
    [btn setBackgroundColor:[UIColor redColor]];
    if (_preBtn != btn) {
        _preBtn = btn;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    int page = _scrollView.contentOffset.x / HY_BOARD_W;//通过滚动的偏移量来判断目前页面所对应的小白点
    _pageControl.currentPage = page;//pagecontroll响应值的变化
    NSUserDefaults *defPage = [NSUserDefaults standardUserDefaults];
    [defPage setInteger:page forKey:@"currentPage"];
    [defPage synchronize];
}

- (void)selectedFacial:(NSString *)str {
    [_delegate selectedFace:str];
}

@end
