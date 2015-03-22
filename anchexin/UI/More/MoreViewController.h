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

#import "CollectionShopViewController.h"//店铺收藏

#import "AccountViewController.h"//账户信息
#import "ModifyPwdViewController.h"//修改密码
#import "CodeViewController.h"//二维码

#import "CarManageViewController.h"//车辆管理

#import "GuideViewController.h"//操作指南
#import "AboutUsViewController.h"//关于我们
#import "FeedbackViewController.h"//意见反馈
#import "SkinViewController.h"//换肤
#import "LoginAndResigerViewController.h"//注册登录界面


#import "New_ActivityViewController.h"//新市场活动

@interface MoreViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *moreTableView;
    NSArray *moreArray;
    NSArray *moreIconArray;
}

@end
