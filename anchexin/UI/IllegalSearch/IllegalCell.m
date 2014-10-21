//
//  IllegalCell.m
//  AnCheXin
//
//  Created by cgx on 14-6-14.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "IllegalCell.h"

@implementation IllegalCell
@synthesize carAreaLabel;
@synthesize carFenLabel;
@synthesize carHandleLabel;
@synthesize carMoneyLabel;
@synthesize carNumberLabel;
@synthesize carResaonLabel;
@synthesize carTimeLabel;
@synthesize carClickButton;
@synthesize carDownView;

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
