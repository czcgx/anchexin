//
//  MaintenanceCell.m
//  anchexin
//
//  Created by cgx on 14-8-21.
//
//

#import "MaintenanceCell.h"

@implementation MaintenanceCell
@synthesize upButton;
@synthesize upImageView;
@synthesize upView;
@synthesize downView;
@synthesize maintenanceTitle;
@synthesize maintenanceMonth;

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
