//
//  CreateHealthyCarViewController.h
//  AnCheXin
//
//  Created by cgx on 13-11-11.
//  Copyright (c) 2013年 LianJia. All rights reserved.
//

#import "BaseViewController.h"

#import "CreateCardCell.h"//创建健康卡
#import "CreateAnswerCardCell.h"

#import "ChangeStateServiceViewController.h"//改变更改项目

@interface CreateHealthyCarViewController : BaseViewController<UITextFieldDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITableView *createCardTableView;
    int n;
    
    NSArray *questionArray;
    NSMutableArray *anwserArray;
    
    UIActionSheet *actionSheet;
    UIDatePicker *dataPickerView;//日期控件
    
    UIPickerView *picker;
    
    int cellTag;
    
   
    int requestFlag;
    
    UILabel *cityLabel;
    NSString *cityStr;
    UIView *mainView;
    
    UIScrollView *healthyScrollView;
    UILabel *showLabel;
    
    NSArray *kiloArray;
    NSMutableArray *kiloMutableArray;
    NSArray *cityArray;
    NSArray *secArray;
    NSArray *otherArray;
    int pt;


}
@property(nonatomic,retain)NSString *blindcarID;//绑定车辆的id
@property(nonatomic,assign)int state;



@end
