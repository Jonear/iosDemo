//
//  HYViewController.h
//  FaceBoard
//
//  Created by 邱扬 on 14-4-8.
//  Copyright (c) 2014年 邱扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYFaceView.h"

@interface HYViewController : UIViewController<HYFaceViewDelegate>

@property (nonatomic, retain) HYFaceView *faceBoard;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *faceBtn;
@property (weak, nonatomic) IBOutlet UITextView *messageText;
- (IBAction)faceBtn:(id)sender;

@end
