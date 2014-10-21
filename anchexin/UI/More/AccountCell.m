//
//  AccountCell.m
//  anchexin
//
//  Created by cgx on 14-8-28.
//
//

#import "AccountCell.h"

@implementation AccountCell
@synthesize nameLabel;
@synthesize valueLabel;
@synthesize iconImageView;
@synthesize lineLabel;

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
