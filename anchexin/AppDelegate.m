//
//  AppDelegate.m
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "AppDelegate.h"

#import "AlixPayResult.h"
#import "DataVerifier.h"


@implementation AppDelegate
@synthesize rootController;
@synthesize tabBarController;
@synthesize currentLatitude;
@synthesize currentLongitude;
@synthesize token;
@synthesize uid;
@synthesize changCarId;

//获取用户当前的位置
-(void)setLocation
{
    locManager = [[CLLocationManager alloc] init];
    // Required
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        
        //[self alertOnly:@"ddddd"];
        //获取授权认证
        [locManager requestAlwaysAuthorization];//始终允许
        //[locManager requestWhenInUseAuthorization];//在使用app的时候允许定位
        
        
    }

    locManager.delegate = self;
    locManager.desiredAccuracy = 10;
    locManager.distanceFilter = 1000.0f;
    [locManager startUpdatingLocation];
    
    
}

//定位时候调用
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
     [AppDelegate setGlobal].currentLatitude=[[NSString alloc]initWithFormat:@"%g",newLocation.coordinate.latitude];
     [AppDelegate setGlobal].currentLongitude=[[NSString alloc]initWithFormat:@"%g",newLocation.coordinate.longitude];
    
     //NSLog(@"currentLatitude::%@,currentLongitude::%@",currentLatitude,currentLongitude);
    
    
}

//定位出错时被调
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [AppDelegate setGlobal].currentLatitude=@"";
    [AppDelegate setGlobal].currentLongitude=@"";
    
    //NSLog(@"currentLatitude::%@,currentLongitude::%@",[AppDelegate setGlobal].currentLatitude,[AppDelegate setGlobal].currentLongitude);
}


-(UITabBarController *)customTabBarController
{
    UITabBarController *custabBarController=[[UITabBarController alloc]init];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        custabBarController.tabBar.barTintColor=kUIColorFromRGB(0x222222);
        custabBarController.tabBar.tintColor=kUIColorFromRGB(0xFFFFFF);//改变字体颜色
    }
    
    custabBarController.delegate=self;
    
    //健康卡
    HealthCardViewController *healthCard=[[HealthCardViewController alloc] init];
    CustomNavigationController *navHealthCard=[[CustomNavigationController alloc]initWithRootViewController:healthCard];
    navHealthCard.navigationBar.topItem.title=@"健康卡";
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        navHealthCard.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"健康卡" image:IMAGE(@"tab1@2x") selectedImage:IMAGE(@"tab1_s")];
    }
    else
    {
        navHealthCard.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"健康卡" image:IMAGE(@"tab1@2x") tag:0];
        navHealthCard.navigationBarHidden=YES;
        
    }
    
    navHealthCard.navigationBar.tintColor=[UIColor clearColor];
    
    //navMessage.tabBarItem.badgeValue=@"12";
    
    //服务网点
    ServiceStationViewController *serviceStation=[[ServiceStationViewController alloc]init];
    serviceStation.state=1;
    //NSLog(@"currentLatitude::%@,currentLongitude::%@",currentLatitude,currentLongitude);
    //serviceStation.lat=currentLatitude;
    //serviceStation.lng=currentLongitude;
    CustomNavigationController *navServiceStation=[[CustomNavigationController alloc]initWithRootViewController:serviceStation];
    navServiceStation.navigationBar.topItem.title=@"服务网点";
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        navServiceStation.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"服务网点" image:IMAGE(@"tab2@2x") selectedImage:IMAGE(@"tab2_s")];
        
    }
    else
    {
        navServiceStation.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"服务网点" image:IMAGE(@"tab2@2x") tag:1];
        navServiceStation.navigationBarHidden=YES;
    }
    
    navServiceStation.navigationBar.tintColor=kUIColorFromRGB(0xFF7676);
    
    //首页
    HomeViewController *home=[[HomeViewController alloc]init];
    CustomNavigationController *navHome=[[CustomNavigationController alloc]initWithRootViewController:home];
    navHome.navigationBar.topItem.title=@"安车信";
    //navMyself.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"我" image:IMAGE(@"tab4") tag:3];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        navHome.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:IMAGE(@"tab3@2x") selectedImage:IMAGE(@"tab3_s")];
        
    }
    else
    {
        navHome.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:IMAGE(@"tab3@2x") tag:2];
        navHome.navigationBarHidden=YES;
    }

    
    //navHome.navigationBarHidden=YES;
    //navHome.navigationBar.barTintColor=kUIColorFromRGB(0x222222);//背景色
    //navHome.navigationBar.tintColor=kUIColorFromRGB(0xFFFFFF);//背景色
    
    //通知提醒
    NoticationsViewController *notications=[[NoticationsViewController alloc]init];
    CustomNavigationController *navNotications=[[CustomNavigationController alloc]initWithRootViewController:notications];
    navNotications.navigationBar.topItem.title=@"通知提醒";
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        navNotications.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"通知提醒" image:IMAGE(@"tab4@2x") selectedImage:IMAGE(@"tab4_s")];
    }
    else
    {
        navNotications.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"通知提醒" image:IMAGE(@"tab4@2x") tag:3];
        navNotications.navigationBarHidden=YES;
        
    }
    
    
    navNotications.navigationBar.tintColor=kUIColorFromRGB(0xFF7676);
    
    //查违章
    IllegalSearchViewController *illegalSearch=[[IllegalSearchViewController alloc]init];
    CustomNavigationController *navIllegalSearch=[[CustomNavigationController alloc]initWithRootViewController:illegalSearch];
    navIllegalSearch.navigationBar.topItem.title=@"查违章";
   
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        navIllegalSearch.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"查违章" image:IMAGE(@"tab5@2x") selectedImage:IMAGE(@"tab5_s")];
        
    }
    else
    {
        navIllegalSearch.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"查违章" image:IMAGE(@"tab5@2x") tag:4];
        navIllegalSearch.navigationBarHidden=YES;
    }
    
    navIllegalSearch.navigationBar.tintColor=kUIColorFromRGB(0xFF7676);
    
    custabBarController.viewControllers=[NSArray arrayWithObjects:navHealthCard,navServiceStation,navHome,navNotications,navIllegalSearch, nil];
    custabBarController.selectedIndex=2;
    
    [AppDelegate setGlobal].tabBarController=custabBarController;
    
    return custabBarController;
}

-(void)tabBarController:(UITabBarController *)tabBarController1 didSelectViewController:(UIViewController *)viewController
{
    if (![AppDelegate setGlobal].token)
    {
        tabBarController1.selectedIndex=2;
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"alertLogin" object:nil];
        
    }
    else if(tabBarController1.selectedIndex==3)
    {
        [[[[[AppDelegate setGlobal].tabBarController viewControllers] objectAtIndex:3] tabBarItem] setBadgeValue:nil];
    }
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url scheme] isEqualToString:AppScheme] == YES)
    {
        [self parse:url application:application];
        return YES;
    }
    
    
    return  [UMSocialSnsService handleOpenURL:url];
}
 

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([[url scheme] isEqualToString:AppScheme] == YES)
    {
        [self parse:url application:application];
        return YES;
    }
    
    return  [UMSocialSnsService handleOpenURL:url];
}

//初始化分享平台
-(void)initializePlat
{
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:weixinId
                            appSecret:weixinKey
                                  url:@"http://www.anchexin.com/"];
    
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:qqId
                               appKey:qqKey
                                  url:@"http://www.anchexin.com/"];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    if (isAppStore)//判断是appstore
    {
        [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:BATCH channelId:nil];//默认
    }
    else
    {
        [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:BATCH channelId:@"anchexin"];
    }
    //[UMSocialData openLog:YES];
    [UMSocialData setAppKey:UMENG_APPKEY];//设置分享appkey
    [MobClick checkUpdate];//检测是否有新版本更新
    
    
    [self initializePlat];//初始化各个分享平台
    
    [self setLocation];//获取自己的位置
    
    //微信支付
    [WXApi registerApp:@"wxdb5c2f69b97549c4" withDescription:@"demo 2.0"];
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret =0;
    if (isAppStore)
    {
        //appstore
        ret=[_mapManager start:@"plNHPND03QWieUAn7o10Vdoz"  generalDelegate:self];
    }
    else
    {
        //官网
        ret=[_mapManager start:@"XwgGchkhZg6X2Yxu1MhGVams"  generalDelegate:self];
    }
    
    if (!ret) {
        NSLog(@"baidu map manager start failed!");
    }
    
    UITabBarController *custabBarController=[self customTabBarController];//自定义tabbar

    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    
    // Required
    [APService setupWithOption:launchOptions];
    
    NSDictionary *pushNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    //NSLog(@"pushNotification::%@",pushNotification);
    if (pushNotification)
    {
        [[[[[AppDelegate setGlobal].tabBarController viewControllers] objectAtIndex:3] tabBarItem] setBadgeValue:@"1"];
    }
 
    
    ReadWriteToDocument *document= [[ReadWriteToDocument alloc]init];
    document.folderName=@"anchexin";
    NSDictionary *userDic=[document readDataFromDocument:@"user" IsArray:NO];
    NSDictionary *carDic=[document readDataFromDocument:@"car" IsArray:NO];
    
    //NSLog(@"user::%@,car::%@",userDic,carDic);
    //int vaild=[[NSUserDefaults standardUserDefaults] integerForKey:@"vaild"];
    
    
    if (userDic && [[userDic objectForKey:@"valid"] intValue]==1 && carDic.count>0 && [[carDic objectForKey:@"license_number"] length]==7)
    {
        
        rootController = [[DDMenuController alloc] initWithRootViewController:custabBarController];
        MoreViewController *more=[[MoreViewController alloc] init];
        rootController.leftViewController = more;
        
        CityViewController *city=[[CityViewController alloc] init];
        rootController.rightViewController=city;
        
        
        self.window.rootViewController = rootController;
    }
    else
    {
        LoginGuideViewController *guide=[[LoginGuideViewController alloc] init];
        
        CustomNavigationController *nav=[[CustomNavigationController alloc] initWithRootViewController:guide];
        if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0)
        {
            nav.navigationBarHidden=YES;
        }
        
        self.window.rootViewController = nav;
    }
  
    
    [self.window makeKeyAndVisible];
    
    return YES;
    
}

//baidu map委托
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError)
    {
        NSLog(@"联网成功");
    }
    else{
        //NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
         NSLog(@"授权成功");
    }
    else {
        //NSLog(@"onGetPermissionState %d",iError);
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Required
    [APService registerDeviceToken:deviceToken];
    
}

//获取apns消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [APService handleRemoteNotification:userInfo];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    
    [[[[[AppDelegate setGlobal].tabBarController viewControllers] objectAtIndex:3] tabBarItem] setBadgeValue:@"1"];
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}


#pragma mark -

- (void)networkDidSetup:(NSNotification *)notification
{
   // NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    //NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification {
    //NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    //NSLog(@"已登录");
}


//获取应用内的消息
- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    //NSDictionary * userInfo = [notification userInfo];
    //NSLog(@"%@",userInfo);
    
    [[[[[AppDelegate setGlobal].tabBarController viewControllers] objectAtIndex:3] tabBarItem] setBadgeValue:@"1"];
    
    /*
    //NSLog(@"userInfo::%@",userInfo);
    
    //系统默认音效
    //AudioServicesPlaySystemSound(1007);
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动
    
    
    //用户自定义音效
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"caf"];
    //组装并播放音效
    SystemSoundID soundID;
    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    AudioServicesPlaySystemSound(soundID);
    */
    
    /*
     //声音停止
     AudioServicesDisposeSystemSoundID(soundID);
     */
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //点击通知栏目里面通知消失，图标右上角的提示数字消失
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //点击通知栏目里面消失
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [self setLocation];//获取地理位置
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//设置全局参数
+(AppDelegate*)setGlobal
{
    return (AppDelegate*)[[UIApplication sharedApplication]delegate];
}



- (void)parse:(NSURL *)url application:(UIApplication *)application
{
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
    //NSLog(@"result::%@",result);
    if (result)
    {
        if (result.statusCode == 9000)
        {
           // NSLog(@"交易成功");
            /*
             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
             */
            
            //交易成功
            //            NSString* key = @"签约帐户后获取到的支付宝公钥";
            //			id<DataVerifier> verifier;
            //            verifier = CreateRSADataVerifier(key);
            //
            //			if ([verifier verifyString:result.resultString withSign:result.signString])
            //            {
            //                //验证签名成功，交易结果无篡改
            //			}
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshPay" object:nil];
        }
        else
        {
            //交易失败
            //NSLog(@"支付error");
        }
    }
    else
    {
        //失败
        //NSLog(@"支付error");
        
    }
    
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url
{
    AlixPayResult * result = nil;
    if (url != nil && [[url host] compare:@"safepay"] == 0)
    {
        result = [self resultFromURL:url];
    }
    
    return result;
}

- (AlixPayResult *)resultFromURL:(NSURL *)url
{
    NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [[AlixPayResult alloc] initWithString:query];
    
}



- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess:
            {
                //服务器端查询支付通知或查询API返回的结果再提示成功
                //NSLog(@"支付成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshPay" object:nil];
                
                
                break;
            }
            default:
                NSLog(@"支付失败， retcode=%d",resp.errCode);
                break;
        }
    }
}

@end
