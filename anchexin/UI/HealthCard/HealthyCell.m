//
//  HealthyCell.m
//  anchexin
//
//  Created by cgx on 14-8-21.
//
//

#import "HealthyCell.h"

@implementation HealthyCell
@synthesize flagImageView;
@synthesize stateLabel;
@synthesize nameLabel;
@synthesize checkImageView;
@synthesize chooseButton;

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
