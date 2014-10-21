//
//  AppDelegate.h
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "HealthCardViewController.h"//健康卡
#import "ServiceStationViewController.h"//服务网点
#import "HomeViewController.h"//首页
#import "NoticationsViewController.h"//通知提醒
#import "IllegalSearchViewController.h"//查违章
#import "MoreViewController.h"

#import "CustomNavigationController.h"//自定义导航栏

#import "DDMenuController.h"
#import "CityViewController.h"

#import "LoginGuideViewController.h"

#import "APService.h"//极光推送

#import "MobClick.h"
#define UMENG_APPKEY @"541a4395fd98c5af4902f89a"//友盟统计APPKey

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,CLLocationManagerDelegate>
{
    
    CLLocationManager *locManager;//定位当前位置参数
    
    //PPRevealSideViewController *revealSideViewController;
    
    
 
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain)DDMenuController *rootController;
@property (nonatomic,retain)UITabBarController *tabBarController;
@property(nonatomic,retain)NSString *currentLatitude;
@property(nonatomic,retain)NSString *currentLongitude;

@property(nonatomic,retain)NSString *token;
@property(nonatomic,retain)NSString *uid;
@property(nonatomic,retain)NSString *changCarId;


+(AppDelegate*)setGlobal;//设置全局参数

-(UITabBarController *)customTabBarController;

@end
