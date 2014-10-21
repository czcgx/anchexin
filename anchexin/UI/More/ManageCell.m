//
//  ManageCell.m
//  anchexin
//
//  Created by cgx on 14-9-13.
//
//

#import "ManageCell.h"

@implementation ManageCell
@synthesize carNameLabel1;
@synthesize carNameLabel2;
@synthesize carNumberLabel;
@synthesize carSnLabel;
@synthesize editButton;

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
