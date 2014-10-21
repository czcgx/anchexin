//
//  AppDelegate.m
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "AppDelegate.h"


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
    
    // NSLog(@"currentLatitude::%@,currentLongitude::%@",currentLatitude,currentLongitude);
    
    
}

//定位出错时被调
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [AppDelegate setGlobal].currentLatitude=@"";
    [AppDelegate setGlobal].currentLongitude=@"";
}


-(UITabBarController *)customTabBarController
{
    UITabBarController *custabBarController=[[UITabBarController alloc]init];
    custabBarController.tabBar.barTintColor=kUIColorFromRGB(0x222222);
    custabBarController.tabBar.tintColor=kUIColorFromRGB(0xFFFFFF);//改变字体颜色
    custabBarController.delegate=self;
    
    //健康卡
    HealthCardViewController *healthCard=[[HealthCardViewController alloc] init];
    CustomNavigationController *navHealthCard=[[CustomNavigationController alloc]initWithRootViewController:healthCard];
    navHealthCard.navigationBar.topItem.title=@"健康卡";
    //navMessage.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"聊天" image:IMAGE(@"tab1") tag:0];
    navHealthCard.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"健康卡" image:IMAGE(@"tab1@2x") selectedImage:IMAGE(@"tab1_s")];
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
    // navFriends.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"好友" image:IMAGE(@"tab2") tag:1];
    navServiceStation.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"服务网点" image:IMAGE(@"tab2@2x") selectedImage:IMAGE(@"tab2_s")];
    navServiceStation.navigationBar.tintColor=kUIColorFromRGB(0xFF7676);
    
    //首页
    HomeViewController *home=[[HomeViewController alloc]init];
    CustomNavigationController *navHome=[[CustomNavigationController alloc]initWithRootViewController:home];
    navHome.navigationBar.topItem.title=@"安车信";
    //navMyself.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"我" image:IMAGE(@"tab4") tag:3];
    navHome.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:IMAGE(@"tab3@2x") selectedImage:IMAGE(@"tab3_s")];
    //navHome.navigationBarHidden=YES;
    //navHome.navigationBar.barTintColor=kUIColorFromRGB(0x222222);//背景色
    //navHome.navigationBar.tintColor=kUIColorFromRGB(0xFFFFFF);//背景色
    
    //通知提醒
    NoticationsViewController *notications=[[NoticationsViewController alloc]init];
    CustomNavigationController *navNotications=[[CustomNavigationController alloc]initWithRootViewController:notications];
    navNotications.navigationBar.topItem.title=@"通知提醒";
    //navMyself.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"我" image:IMAGE(@"tab4") tag:3];
    navNotications.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"通知提醒" image:IMAGE(@"tab4@2x") selectedImage:IMAGE(@"tab4_s")];
    
    navNotications.navigationBar.tintColor=kUIColorFromRGB(0xFF7676);
    
    //查违章
    IllegalSearchViewController *illegalSearch=[[IllegalSearchViewController alloc]init];
    CustomNavigationController *navIllegalSearch=[[CustomNavigationController alloc]initWithRootViewController:illegalSearch];
    navIllegalSearch.navigationBar.topItem.title=@"查违章";
    //navMyself.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"我" image:IMAGE(@"tab4") tag:3];
    navIllegalSearch.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"查违章" image:IMAGE(@"tab5@2x") selectedImage:IMAGE(@"tab5_s")];
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
    }
    else if(tabBarController1.selectedIndex==3)
    {
        [[[[[AppDelegate setGlobal].tabBarController viewControllers] objectAtIndex:3] tabBarItem] setBadgeValue:nil];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:BATCH channelId:nil];//默认为
    [MobClick checkUpdate];//检测是否有新版本更新
    
    [self setLocation];//获取自己的位置
    UITabBarController *custabBarController=[self customTabBarController];//自定义tabbar

    // Required
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                         UIRemoteNotificationTypeSound |
                                         UIRemoteNotificationTypeAlert)];
    // Required
    [APService setupWithOption:launchOptions];
    
    //监听通知
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];// 收到消息(非APNS)
    
    
    NSDictionary *pushNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    //NSLog(@"pushNotification::%@",pushNotification);
    if (pushNotification)
    {
        [[[[[AppDelegate setGlobal].tabBarController viewControllers] objectAtIndex:3] tabBarItem] setBadgeValue:@"1"];
    }
 
    
    ReadWriteToDocument *document= [[ReadWriteToDocument alloc]init];
    document.folderName=@"anchexin";
    NSDictionary *userDic=[document readDataFromDocument:@"user" IsArray:NO];
    NSArray *carArray=[document readDataFromDocument:@"car" IsArray:YES];
    
    //NSLog(@"user::%@,car::%@",userDic,carArray);
    //int vaild=[[NSUserDefaults standardUserDefaults] integerForKey:@"vaild"];
    
    if (userDic && [[userDic objectForKey:@"valid"] intValue]==1 && carArray.count>0 && [[[carArray objectAtIndex:0] objectForKey:@"license_number"] length]==7)
    {
        
        rootController = [[DDMenuController alloc] initWithRootViewController:custabBarController];
        MoreViewController *more=[[MoreViewController alloc] init];
        rootController.leftViewController = more;
        
        CityViewController *city=[[CityViewController alloc] init];
        rootController.rightViewController=city;
        self.window.rootViewController = rootController;
    }
    else if(userDic && carArray.count==0)
    {
        [AppDelegate setGlobal].token=[userDic objectForKey:@"token"];
        [AppDelegate setGlobal].uid=[userDic objectForKey:@"userid"];
        
        //选择车辆
        CarTypeViewController *type=[[CarTypeViewController alloc] init];
        type.state=1;
        CustomNavigationController *customNav=[[CustomNavigationController alloc] initWithRootViewController:type];
        self.window.rootViewController = customNav;
        
    }
    else if (userDic && [[[carArray objectAtIndex:0] objectForKey:@"license_number"] length]==0)
    {
        [AppDelegate setGlobal].token=[userDic objectForKey:@"token"];
        [AppDelegate setGlobal].uid=[userDic objectForKey:@"userid"];
        
        //创建健康卡
        CreateHealthyCarViewController *create=[[CreateHealthyCarViewController alloc] init];
        create.blindcarID=[[carArray objectAtIndex:0] objectForKey:@"carid"];
        create.state=1;
        CustomNavigationController *customNav=[[CustomNavigationController alloc] initWithRootViewController:create];
        self.window.rootViewController = customNav;
    }
    else
    {
        LoginGuideViewController *guide=[[LoginGuideViewController alloc] init];
        CustomNavigationController *nav=[[CustomNavigationController alloc] initWithRootViewController:guide];
        
        self.window.rootViewController = nav;
        
        
         /*
        //创建健康卡
        CreateHealthyCarViewController *create=[[CreateHealthyCarViewController alloc] init];
        //create.blindcarID=[[carArray objectAtIndex:0] objectForKey:@"carid"];
        create.state=0;
        CustomNavigationController *customNav=[[CustomNavigationController alloc] initWithRootViewController:create];
        
         self.window.rootViewController = customNav;
          */
        /*
        OrderViewController *create=[[OrderViewController alloc] init];
        //create.blindcarID=[[carArray objectAtIndex:0] objectForKey:@"carid"];
        CustomNavigationController *customNav=[[CustomNavigationController alloc] initWithRootViewController:create];
        
        self.window.rootViewController = customNav;
         */
        
        
    }
  
    
    [self.window makeKeyAndVisible];
    
    return YES;
    
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


@end
