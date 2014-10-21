//
//  IllegalCell.h
//  AnCheXin
//
//  Created by cgx on 14-6-14.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IllegalCell : UITableViewCell
{
    IBOutlet UILabel *carNumberLabel;
    IBOutlet UILabel *carTimeLabel;
    IBOutlet UILabel *carAreaLabel;
    IBOutlet UILabel *carResaonLabel;
    IBOutlet UILabel *carFenLabel;
    IBOutlet UILabel *carMoneyLabel;
    IBOutlet UILabel *carHandleLabel;
    IBOutlet UIButton *carClickButton;
    
    IBOutlet UIView *carDownView;
    

}

@property(nonatomic,retain)UILabel *carNumberLabel;
@property(nonatomic,retain)UILabel *carTimeLabel;
@property(nonatomic,retain)UILabel *carAreaLabel;
@property(nonatomic,retain)UILabel *carResaonLabel;
@property(nonatomic,retain)UILabel *carFenLabel;
@property(nonatomic,retain)UILabel *carMoneyLabel;
@property(nonatomic,retain)UILabel *carHandleLabel;
@property(nonatomic,retain)UIButton *carClickButton;
@property(nonatomic,retain)UIView *carDownView;

@end
