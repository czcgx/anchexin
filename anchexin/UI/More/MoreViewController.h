//
//  MoreViewController.h
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "BaseViewController.h"
#import "MoreCell.h"

#import "MyOrderViewController.h"//我的订单
#import "AnalysisViewController.h"//行程分析
#import "VehicleDiagnosisViewController.h"//车况诊断
#import "ActivityViewController.h"//市场活动

#import "AccountViewController.h"//账户信息
#import "ModifyPwdViewController.h"//修改密码
#import "CodeViewController.h"//二维码
#import "BlindOBDViewController.h"//设备绑定
#import "CarManageViewController.h"//车辆管理

#import "GuideViewController.h"//操作指南
#import "AboutUsViewController.h"//关于我们
#import "SkinViewController.h"//换肤
#import "LoginAndResigerViewController.h"//注册登录界面

#import "RegisterViewController.h"//注册

@interface MoreViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *moreTableView;
    NSArray *moreArray;
    NSArray *moreIconArray;
}

@end
