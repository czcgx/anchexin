//
//  ActivitiyInfoViewController.m
//  AnCheXin
//
//  Created by cgx on 14-7-11.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "ActivitiyInfoViewController.h"

#import "AlixLibService.h"//请求你
#import "AlixPayOrder.h"
#import "AlixPayResult.h"//返回结果
#import "DataSigner.h"
#import "DataVerifier.h"

@interface ActivitiyInfoViewController ()

@end

@implementation ActivitiyInfoViewController
@synthesize activityInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    self.title=@"活动详情";

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshPay)
                                                 name:@"refreshPay"
                                                object:nil];
     
    
    activityWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, NavigationBar,WIDTH,480-NavigationBar+(iPhone5?88:0))];
    activityWebView.delegate=self;
    //[[NSURLCache sharedURLCache] removeAllCachedResponses];
    [activityWebView setScalesPageToFit:YES];
    [activityWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[activityInfo objectForKey:@"url"]]]];//
    
    [self.view addSubview:activityWebView];
    
   
    //[ToolLen ShowWaitingView:YES];
    //requestFlag=1;
   // [[self JsonFactory]getActivityDetail:[activityInfo objectForKey:@"id"] action:@"getActivityDetail"];
    
    
}

/*
-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==2)
    {
        if ([[userDic objectForKey:@"valid"] intValue]==0)
        {
            [self alertNoValid];
        }
        else
        {
            requestFlag=2;
            [[self JsonFactory]getActivityDetail:[activityInfo objectForKey:@"id"] action:@"receiveActivity"];
        }
       
    }
}
 */


 /*
-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
   // NSLog(@"responseObject::%@",responseObject);
    
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestFlag==1)
    {
         [activityWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[responseObject objectForKey:@"url"]]]];
    }
   
    else  if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestFlag==2)
    {
        [activityWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[responseObject objectForKey:@"url"]]]];
        
        [titleView removeFromSuperview];
        titleView=[self customView:CGRectMake(20, 7, 280, 35) labelTitle:@"活动已经领取" buttonTag:1];
        [view addSubview:titleView];
    }
  
    
    else
    {
        [self alertOnly:[responseObject objectForKey:@"message"]];
    }
}
*/

#pragma mark －webview的委托代理的实现
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //[ToolLen ShowWaitingView:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    //[ToolLen ShowWaitingView:NO];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    //[ToolLen ShowWaitingView:NO];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil
                                                 message:@"由于网络原因,网页无法显示,请稍后尝试..."
                                                delegate:nil
                                       cancelButtonTitle:@"确定"
                                       otherButtonTitles: nil];
    [alert show];
    
    

}

/*
// 网页中的每一个请求都会被触发
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [[request URL] absoluteString];
    NSLog(@"urlString:%@",urlString);
    
    NSLog(@"maindocu::%@",request.mainDocumentURL.relativePath);
    
    // 每次跳转时候判断URL
    if([request.mainDocumentURL.relativePath isEqualToString:@"/getInfo/why"])
    {
        NSLog(@"why");
        return NO;
    }
    
    return YES;
}
*/


/**
 *开始加重请求拦截
 */

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *urlstr = request.URL.absoluteString;
    NSLog(@"urlstr::%@",urlstr);
    //app://%7Buser:1565,activity:161,price:0%7D
    NSRange range = [urlstr rangeOfString:@"app://"];

    if (range.length!=0)
    {
        NSString *method = [[urlstr substringFromIndex:(range.length)]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //NSLog(@"method::%@",(NSDictionary *)method);
        //NSDictionary *tempDic=(NSDictionary *)method;
        //NSLog(@"temp::%@",[tempDic objectForKey:@"activity"]);
        
        NSString *method1=[[method substringFromIndex:1] substringToIndex:method.length-2];
        
        //NSLog(@"method1::%@",method1);
    
        [self performSelector:@selector(paySource:) withObject:method1];
        
        return NO;
        
    }
    return YES;
}


-(UIView *)popPayView
{
    UIView *popAlertView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0))];
    popAlertView.backgroundColor=[UIColor clearColor];
    //popAlertView.alpha=0.8;
    
    
    UIView *bgView=[[UIView alloc] initWithFrame:popAlertView.bounds];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0.4;
    [popAlertView addSubview:bgView];
    
    UIView *contentView=[[UIView alloc] initWithFrame:CGRectMake(20,120, 280, 140)];
    contentView.backgroundColor=[UIColor whiteColor];
    
    contentView.layer.cornerRadius = 8.0;//(值越大，角就越圆)
    contentView.layer.masksToBounds = YES;
    contentView.layer.borderWidth=2.0;
    contentView.layer.borderColor=[[UIColor clearColor] CGColor];
    /*
     contentView.layer.cornerRadius = 1.0f;
     contentView.layer.borderColor = [UIColor clearColor].CGColor;
     contentView.layer.borderWidth = 2.0f;
     */
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"UMSocialSDKResourcesNew.bundle/Buttons/UMS_shake_close_tap@2x" ofType:@"png" ];
    UIImageView *p=[[UIImageView alloc] initWithFrame:CGRectMake(240, 15, 20, 20)];
    p.image=[UIImage imageWithContentsOfFile:filePath];
    [contentView addSubview:p];
    [contentView addSubview:[self customButton:p.frame tag:20 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    [contentView addSubview:[self customLabel:CGRectMake(20, 40, 100, 20) color:[UIColor blackColor] text:@"支付方式：" alignment:-1 font:15.0]];
    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"weixinPay" ofType:@"png" ];
    UIImageView *p1=[[UIImageView alloc] initWithFrame:CGRectMake(30, 80, 100, 32)];
    p1.image=[UIImage imageWithContentsOfFile:filePath1];
    [contentView addSubview:p1];
    [contentView addSubview:[self customButton:p1.frame tag:21+100 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"zhifubaoPay" ofType:@"png" ];
    UIImageView *p2=[[UIImageView alloc] initWithFrame:CGRectMake(150, 80, 100, 32)];
    p2.image=[UIImage imageWithContentsOfFile:filePath2];
    [contentView addSubview:p2];
    [contentView addSubview:[self customButton:p2.frame tag:22+100 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    [popAlertView addSubview:contentView];
    
    return popAlertView;
}

//隐藏
-(void)hiddenShow
{
    [alertView removeFromSuperview];
    
}

-(void)paySource:(NSString *)method
{
   // NSLog(@"method::%@",method);
 
    //NSLog(@"array::%@",[method componentsSeparatedByString:@","]);
    payArray=[[NSArray alloc] initWithArray:[method componentsSeparatedByString:@","]];
    //NSLog(@"payArray::%@",payArray);
    
    if ([[userDic objectForKey:@"valid"] intValue]==0)
    {
        //[self alertNoValid];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil
                                                      message:@"您当前是体验账户,如需操作,请注册或登录"
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"注册/登录",nil];
        
        [alert show];
        
    }
    else
    {
        if ([[[[payArray objectAtIndex:2]componentsSeparatedByString:@":"]objectAtIndex:1] intValue]>0)
        {
            /*
            [alertView removeFromSuperview];
            
            alertView=[self popPayView];
            [self.view addSubview:alertView];
            CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            popAnimation.duration = 0.4;
            popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DIdentity]];
            popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
            popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            
            [alertView.layer addAnimation:popAnimation forKey:nil];
             */
            
            //支付宝支付
            if ([[userDic objectForKey:@"valid"] intValue]==0)
            {
                [self alertNoValid];
            }
            else
            {
                [[self JsonFactory]addOrderByActivity:[[[payArray objectAtIndex:1]componentsSeparatedByString:@":"]objectAtIndex:1] paySource:@"1" action:@"addOrderByActivity"];
            }
        }
        else
        {
             [[self JsonFactory]addOrderByActivity:[[[payArray objectAtIndex:1]componentsSeparatedByString:@":"]objectAtIndex:1] paySource:@"1" action:@"addOrderByActivity"];
        }
    }
    
}


-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==20)
    {
        [self hiddenShow];
    }
    else if (sender.tag==121)
    {
        //微信支付
        //NSLog(@"微信支付");
        [self hiddenShow];
        
    }
    else if (sender.tag==122)
    {
        [self hiddenShow];
        //支付宝支付
        if ([[userDic objectForKey:@"valid"] intValue]==0)
        {
            [self alertNoValid];
        }
        else
        {
            /*
            [ToolLen ShowWaitingView:YES];
            requestTimes=10;
            
            NSMutableString *payCode=[[NSMutableString alloc]initWithCapacity:0];
            
            for (int i=0; i<chooseArray.count; i++)
            {
                [payCode appendString:[[chooseArray objectAtIndex:i] objectForKey:@"code"]];
                if (i<chooseArray.count-1) {
                    [payCode appendString:@","];
                }
            }
            
            [[self JsonFactory] addOrder:[stationInfo objectForKey:@"repairstationid"] serviceList:payCode paySource:@"1" action:@"addOrder"];
             */
            
            [[self JsonFactory]addOrderByActivity:[[[payArray objectAtIndex:1]componentsSeparatedByString:@":"]objectAtIndex:1] paySource:@"1" action:@"addOrderByActivity"];
        }
    }

}

-(void)JSONSuccess:(id)responseObject
{
    NSLog(@"respon::%@",responseObject);
    
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0)
    {
        payInfo=[[NSDictionary alloc] initWithDictionary:responseObject];
        NSLog(@"payInfo::%@",payInfo);
        if ([[payInfo objectForKey:@"needPay"] intValue]>0)
        {
            [self pay];
        }
        else
        {
            [self alertOnly:@"您已经抢到"];
        }
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1)
    {
        // NSLog(@"登录");
        LoginAndResigerViewController *guide=[[LoginAndResigerViewController alloc] init];
        [self.navigationController pushViewController:guide animated:YES];
    }
}


//支付成功的回调
-(void)refreshPay
{
    //进入我的订单列表
    MyOrderViewController *myorder=[[MyOrderViewController alloc] init];
    myorder.title=@"我的订单";
    myorder.state=0;
    myorder.selected=1;
    [self.navigationController pushViewController:myorder animated:YES];
    
}



//wap回调函数
-(void)paymentResult:(NSString *)resultd
{
    //结果处理
    AlixPayResult * result = [[AlixPayResult alloc] initWithString:resultd];
    //NSLog(@"result::%@",result);
    
    if (result)
    {
        if (result.statusCode == 9000)
        {
            /*
             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
             */
            //交易成功
            NSString* key =AlipayPubKey;//签约帐户后获取到的支付宝公钥
            id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
                [self refreshPay];
            }
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}


-(void)pay
{
    NSString *appScheme=nil;
    
    appScheme = @"anchexinPay";//在plist中设置的回调地址
    
    NSString* orderInfo = [self getOrderInfo];//订单
    // NSLog(@"orderInfo:%@",orderInfo);
    
    NSString* signedStr = [self doRsa:orderInfo];
    //NSLog(@"signedStr:%@",signedStr);
    
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
    
    // NSLog(@"order:%@",orderString);
    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:@selector(paymentResult:) target:self];
    
}

-(NSString*)getOrderInfo
{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = [payInfo objectForKey:@"orderNo"]; //订单ID（由商家自行制定）
    order.productName =[payInfo objectForKey:@"title"]; //商品标题
    order.productDescription=[payInfo objectForKey:@"description"]; //商品描述
    order.amount =[NSString stringWithFormat:@"%@",[[[payArray objectAtIndex:2]componentsSeparatedByString:@":"]objectAtIndex:1]]; //商品价格
    order.notifyURL =[payInfo objectForKey:@"url"]; //回调URL
    
    return [order description];
    
    
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}



// 构造订单参数列表
- (NSDictionary *)getProductArgs
{
    //self.timeStamp = [self genTimeStamp];   // 获取时间戳
    //self.nonceStr = [self genNonceStr];     // 获取32位内的随机串, 防重发
    //self.traceId = [self genTraceId];       // 获取商家对用户的唯一标识
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //[params setObject:WXAppId forKey:@"appid"];//公众账号ID
    //?[params setObject:WXAppKey forKey:@"appkey"];
    //[params setObject:self.timeStamp forKey:@"noncestr"];//随机字符串
    //?[params setObject:self.timeStamp forKey:@"timestamp"];
    // [params setObject:self.traceId forKey:@"traceid"];
    //[params setObject:[self genPackage] forKey:@"package"];
    // [params setObject:[self genSign:params] forKey:@"app_signature"];
    // [params setObject:@"sha1" forKey:@"sign_method"];
    
    return params;
}



-(void)weixinPay
{
    
    //拼接详细的订单数据
    //NSDictionary *postDict = [self getProductArgs];
    
    //NSLog(@"postDict::%@",postDict);
    
    
    PayReq *request = [[PayReq alloc] init];
    
    /** 商家向财付通申请的商家id */
    request.partnerId = @"10000100";
    /** 预支付订单 */
    request.prepayId= @"1101000000140415649af9fc314aa427";
    /** 商家根据财付通文档填写的数据和签名 */
    request.package = @"prepay_id=1101000000140415649af9fc314aa427";
    /** 随机串，防重发 */
    request.nonceStr= @"a462b76e7436e98e0ed6e13c64b4fd1c";
    /** 时间戳，防重发 */
    request.timeStamp=1397527777;
    /** 商家根据微信开放平台文档对数据做的签名 */
    request.sign= @"582282d72dd2b03ad892830965f428cb16e7a256";
    
    [WXApi sendReq:request];
    
}


@end
