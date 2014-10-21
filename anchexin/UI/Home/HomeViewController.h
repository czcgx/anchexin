//
//  HomeViewController.h
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "BaseViewController.h"
#import "DKLiveBlurView.h"//滤镜

#import "MoreViewController.h"
#import "CarChooseCell.h"

#import "LoginGuideViewController.h"

@interface HomeViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *homeTableView;
    
    UIView *subContentView;
    
    UITableView *carChooseListTableView;
    
    UIImageView *carIconImageView;//当前车辆图标
    UILabel *carIconLabel;//当前车辆车牌号
    
    DKLiveBlurView *backgroundView;
    
    int requestTimes;
    
    NSDictionary *weatherDic;
    NSDictionary *oilDic;
    
    UILabel *root_healthIndexLabel;//健康指数
    UIImageView *root_weatherImageView;//天气图标
    UILabel *root_upWeatherLabel;//当前温度
    UILabel *root_downWeatherLabel;//温度范围
    
    UILabel *root_upEngineOilLabel;//调价天数
    UILabel *root_downEngineOilLabel;//调价范围
    
    UIView *popView;
    NSArray *carListArray;
    
}

@property(nonatomic,retain) UITableView *homeTableView;

@end
