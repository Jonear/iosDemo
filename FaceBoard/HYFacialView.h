//
//  HYFacialView.h
//  FaceBoard
//
//  Created by 邱扬 on 14-4-8.
//  Copyright (c) 2014年 邱扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmojiEmoticons.h"
#import "Emoji.h"
#import "EmojiMapSymbols.h"
#import "EmojiPictographs.h"
#import "EmojiTransport.h"

//表情的行列数目
#define HY_FACIAL_ROW 3
#define HY_FACIAL_COL 7
#define HY_FACIAL_ALL (HY_FACIAL_ROW * HY_FACIAL_COL)
//表情的最后一行，用于delete和send
#define HY_FACIAL_ENDROW 2
//表情的大小
#define HY_FACIAL_SIZE_X 43
#define HY_FACIAL_SIZE_Y 43

@protocol HYFacialViewDelegate <NSObject>

- (void)selectedFacial:(NSString *)str;

@end

@interface HYFacialView : UIView

@property (nonatomic, retain) NSArray *faces;   //存放表情
@property (nonatomic, retain) UILabel *faceLabel;
@property (nonatomic, retain) NSString *strText;

@property (nonatomic, assign) NSInteger currentPage;  //当前所在页面
@property (nonatomic, retain) id<HYFacialViewDelegate> delegate;

-(void)loadFacialView:(int)page size:(CGSize)size;

@end
