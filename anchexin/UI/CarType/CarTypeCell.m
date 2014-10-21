//
//  CarTypeCell.m
//  AnCheXin
//
//  Created by cgx on 13-11-11.
//  Copyright (c) 2013年 LianJia. All rights reserved.
//

#import "CarTypeCell.h"

@implementation CarTypeCell

@synthesize carTypeName;
@synthesize imageViewIcon;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
