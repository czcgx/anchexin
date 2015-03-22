//
//  Station3Cell.h
//  anchexin
//
//  Created by cgx on 14-12-7.
//
//

#import <UIKit/UIKit.h>

@interface Station3Cell : UITableViewCell
{
    IBOutlet UIButton *taocanBtn;
    
    IBOutlet UILabel *chooseNumLabel;//选择产品数量
    IBOutlet UILabel *chooseNameLabel;//选择产品名称
    
    IBOutlet UILabel *youhuiDesLabel;//折扣力度
    IBOutlet UILabel *shopPayLabel;//到店付款金额
    IBOutlet UILabel *linePayLabel;//线上付款金额
    
    IBOutlet UIView *subView;
    
    IBOutlet UIButton *orderBtn;//预约按钮
    IBOutlet UIButton *linePayBtn;//线上付款按钮
    
    IBOutlet UIView *layerView;
    
}
@property(nonatomic,retain)UIButton *taocanBtn;

@property(nonatomic,retain)UILabel *chooseNumLabel;
@property(nonatomic,retain)UILabel *chooseNameLabel;

@property(nonatomic,retain)UILabel *youhuiDesLabel;
@property(nonatomic,retain)UILabel *shopPayLabel;
@property(nonatomic,retain)UILabel *linePayLabel;
@property(nonatomic,retain)UIButton *linePayBtn;
@property(nonatomic,retain)UIButton *orderBtn;

@property(nonatomic,retain)UIView *subView;

@property(nonatomic,retain)UIView *layerView;

@end
