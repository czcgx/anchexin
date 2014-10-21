//
//  ActivitiyCell.h
//  AnCheXin
//
//  Created by cgx on 14-7-11.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivitiyCell : UITableViewCell
{
    IBOutlet UIImageView *shopImageView;
    IBOutlet UILabel *activityNameLabel;
    IBOutlet UILabel *shopNameLabel;
    IBOutlet UILabel *carNameLabel;
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *isRequest;
}

@property(nonatomic,retain)UIImageView *shopImageView;
@property(nonatomic,retain)UILabel *activityNameLabel;
@property(nonatomic,retain)UILabel *shopNameLabel;
@property(nonatomic,retain)UILabel *carNameLabel;
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)UILabel *isRequest;

@end
