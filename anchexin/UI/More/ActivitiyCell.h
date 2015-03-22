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
    IBOutlet UILabel *activitydesLabel;
    IBOutlet UILabel *activityDiscountLabel;

}

@property(nonatomic,retain)UIImageView *shopImageView;

@property(nonatomic,retain)UILabel *activityNameLabel;
@property(nonatomic,retain)UILabel *activitydesLabel;
@property(nonatomic,retain)UILabel *activityDiscountLabel;


@end
