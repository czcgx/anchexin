//
//  New_StationInfoViewController.h
//  anchexin
//
//  Created by cgx on 14-12-7.
//
//

#import "BaseViewController.h"
#import "Station1Cell.h"
#import "Station2Cell.h"
#import "Station3Cell.h"
#import "Station4Cell.h"
#import "Station5Cell.h"

#import "ProductPackageViewController.h"//产品套餐
#import "ActivityListViewController.h"//活动列表
#import "DisscussListViewController.h"//评论列表
#import "StationImgViewController.h"//点击图片查看大图
#import "MapViewController.h"

#import "WXApi.h"

@interface New_StationInfoViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImage *image1;
    UIButton *btn;
    UITableView *shopTableView;
    int requestTimes;
    
    NSMutableDictionary *collectInfo;
    
    NSString *testStr;
    NSDictionary *receiveDic;//获取信息
    
    UIView *alertView;
    
    NSArray *chooseArray;
    NSMutableString *appendString;
    
    NSDictionary *payInfo;
    
    int payCountPrice;
}

@property(nonatomic,retain)NSDictionary *stationInfo;

@end
