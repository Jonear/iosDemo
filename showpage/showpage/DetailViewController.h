//
//  DetailViewController.h
//  showpage
//
//  Created by 余 成海 on 13-7-26.
//  Copyright (c) 2013年 余 成海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareDelegate.h"

#define SAVEDIR "/tlxm"

@interface DetailViewController : UIViewController<UIWebViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIView *toolView;                            //底下的工具视图
@property (strong, nonatomic) IBOutlet UIWebView *webView;                        //web游览器
@property (nonatomic) BOOL isLoadToFile;                                          //用于是否记录页面文件
@property (strong, nonatomic) id<sendMsgToWXDelegate> delegate;                   //分享的委托
@property (strong, nonatomic) NSString* articleID;                                //详情页文章ID
/*
 加载页面
 */
- (void) loadWebWithString: (NSString*) url id:(NSString*)id;
- (void) loadWebWithURL: (NSURL*) url id:(NSString*)id;
- (BOOL) loadWebWithFileHtml: (NSString*)filename;

/*
 记录html到本地文件
 */
- (void) saveHtmlToFile:(NSString*)filename;
/*
 点击分享按钮
 */
- (IBAction)shareButtonClick:(id)sender;
/*
 点击编辑按钮
 */
- (IBAction)editButtonClick:(id)sender;

@end
