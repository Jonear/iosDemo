//
//  ShareDelegate.m
//  showpage
//
//  Created by 余成海 on 13-8-1.
//  Copyright (c) 2013年 余 成海. All rights reserved.
//

#import "ShareDelegate.h"
#import "MessageUI/MFMessageComposeViewController.h"

@implementation ShareDelegate

-(id) init
{
    //注册微信
    [WXApi registerApp:@"wx38219725edb54faa"];
    //注册新浪微博
    //[WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:@"2493190902"];
    //注册腾讯
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"100494742" andDelegate:self];
    return self;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////微信分享
#pragma mark - wx delegate


-(void) onReq:(BaseReq*)req
{
    //
}

-(void) onResp:(NSObject*)resp
{
    //微信
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        /*NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
        NSString *strMsg = [NSString stringWithFormat:@"发送消息结果:%d", resp.errCode];
        NSLog(@"%@",strMsg);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];*/
        SendMessageToWXResp* r = (SendMessageToWXResp*)resp;
        if(r.errCode == 0)
        {
            NSLog(@"微信分享成功");
        }
        else
        {
            NSLog(@"微信分享失败");
        }
    }
    //QQ
    else if([resp isKindOfClass:[SendMessageToQQResp class]])
    {
        SendMessageToQQResp* r = (SendMessageToQQResp*)resp;
        //NSLog(@"%@",r.result);
        if([r.result intValue] == 0)
        {
            NSLog(@"QQ分享成功");
        }
        else
        {
            NSLog(@"QQ分享失败");
        }
    }
}
- (void) sendMsgToWX:(NSString*)content title:(NSString*)title image:(UIImage*)image weburl:(NSString*)url scene:(int)scene
{
    if([WXApi isWXAppInstalled])
    {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = content;
        [message setThumbImage:image];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = url;
        
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = scene;  //选择发送到朋友圈，默认值为WXSceneSession，发送到会话
        
        self.shareType = SHARETOWX;
        
        [WXApi sendReq:req];
    }
    //如果没有安装微信，提示
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"本机未安装微信客户端"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
- (void) sendMsgToWXSession:(NSString*)content title:(NSString*)title image:(UIImage*)image weburl:(NSString*)url
{
    [self sendMsgToWX:content title:title image:image weburl:url scene:WXSceneSession];
}

- (void) sendMsgToWXTimeLine:(NSString*)content title:(NSString*)title image:(UIImage*)image weburl:(NSString*)url
{
    [self sendMsgToWX:content title:title image:image weburl:url scene:WXSceneTimeline];
}
/*跳转到微信下载页面
 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
 {
 if (buttonIndex == 0) {
 
 }
 else if(buttonIndex == 1)
 {
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
 }
 }*/
//////////////////////////////////////////////////////////////////////////////////////////////////////短信分享
- (void) sendMsgToSMS:(NSString*)content
{
    /*MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = @"Hello from Mugunth";
        controller.recipients = nil;
        controller.messageComposeDelegate = self;
       // [self presentModalViewController:controller animated:YES];
    }*/
}
//////////////////////////////////////////////////////////////////////////////////////////////////////新浪微博分享
#pragma mark - xlwb delegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    //
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        /*
        NSString *title = @"发送结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
                             response.statusCode, response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
         */
        if(response.statusCode == 0)
        {
            NSLog(@"新浪微博分享成功");
        }
        else
        {
            NSLog(@"新浪微博分享失败");
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        //NSString *title = @"认证结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
                             response.statusCode, [(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
        NSLog(@"%@",message);
    }
}
- (void) sendMsgToXLWB:(NSString*)content title:(NSString*)title imagename:(NSString*)image imagetype:(NSString*)type weburl:(NSString*)url
{
    
    
    if([WeiboSDK isWeiboAppInstalled])
    {
        WBMessageObject *message = [WBMessageObject message];
    
        //文本信息
        message.text = [NSString stringWithFormat:@"#天龙小秘分享#%@ %@", title, url];
    
        //图片信息
        WBImageObject *img = [WBImageObject object];
        img.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:image ofType:type]];
        message.imageObject = img;
    
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    
        request.userInfo = @{@"ShareMessageFrom": @"ViewController"};
    
        //没安装微博的时候不进行跳转安装页面
        request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    
        self.shareType = SHARETOXLWB;
    
        [WeiboSDK sendRequest:request];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"本机未安装新浪微博客户端"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
         /*
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = @"http://weibo.com";
        request.scope = @"email,direct_messages_write";
        request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController"};
        [WeiboSDK sendRequest:request];
          */
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tencentDidLogin
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"登入QQ客户端成功"
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}
- (void) sendMsgToQQ:(NSString*)content title:(NSString*)title imagename:(NSString*)image imagetype:(NSString*)type weburl:(NSString*)url
{
    
    if([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi])
    {
        
        QQApiNewsObject *object = [QQApiNewsObject objectWithURL:[[NSURL alloc]initWithString:url] title:title description:content previewImageData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:image ofType:type]]];
        
        SendMessageToQQReq *message = [SendMessageToQQReq reqWithContent:object];
        message.type = ESENDMESSAGETOQQREQTYPE;
        
        self.shareType = SHARETOQQ;
        
        [QQApiInterface sendReq:message];

        //NSArray *permissions = [NSArray arrayWithObjects:@"add_share", nil];
        //[self.tencentOAuth authorize:permissions inSafari:NO];
    }
    //如果没有装手机QQ
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"本机未安装QQ客户端"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


@end
