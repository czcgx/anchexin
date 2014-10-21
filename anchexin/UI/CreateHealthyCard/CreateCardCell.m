//
//  CreateCardCell.m
//  AnCheXin
//
//  Created by cgx on 13-11-11.
//  Copyright (c) 2013年 LianJia. All rights reserved.
//

#import "CreateCardCell.h"

@implementation CreateCardCell
@synthesize helloLabel;
@synthesize mainView;
@synthesize okButton;
@synthesize textField;
@synthesize cellBg;
@synthesize titleLabel;
@synthesize pLabel;
@synthesize inputTextFieldbg;

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
