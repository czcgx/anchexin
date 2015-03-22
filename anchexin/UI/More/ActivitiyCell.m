//
//  ActivitiyCell.m
//  AnCheXin
//
//  Created by cgx on 14-7-11.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "ActivitiyCell.h"

@implementation ActivitiyCell
@synthesize shopImageView;

@synthesize activityNameLabel;
@synthesize activitydesLabel;
@synthesize activityDiscountLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
