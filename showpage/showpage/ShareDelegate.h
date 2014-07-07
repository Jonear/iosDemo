//
//  ShareDelegate.h
//  showpage
//
//  Created by 余成海 on 13-8-1.
//  Copyright (c) 2013年 余 成海. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

enum ShareType{
    SHARETOXLWB,
    SHARETOWX,
    SHARETOQQ
};

@protocol sendMsgToWXDelegate <NSObject>
- (void) sendMsgToWXSession:(NSString*)content title:(NSString*)title image:(UIImage*)image weburl:(NSString*)url;
- (void) sendMsgToWXTimeLine:(NSString*)content title:(NSString*)title image:(UIImage*)image weburl:(NSString*)url;
- (void) sendMsgToXLWB:(NSString*)content title:(NSString*)title imagename:(NSString*)image imagetype:(NSString*)type weburl:(NSString*)url;
- (void) sendMsgToQQ:(NSString*)content title:(NSString*)title imagename:(NSString*)image imagetype:(NSString*)type weburl:(NSString*)url;
- (void) sendMsgToSMS:(NSString*)content;
@end

@interface ShareDelegate : NSObject <WXApiDelegate, sendMsgToWXDelegate, WeiboSDKDelegate, TencentSessionDelegate, QQApiInterfaceDelegate>

@property (nonatomic) enum ShareType shareType;

@property (strong, nonatomic) TencentOAuth *tencentOAuth;

@end
