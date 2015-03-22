//
//  ServiceCell.m
//  anchexin
//
//  Created by cgx on 14-8-22.
//
//

#import "ServiceCell.h"

@implementation ServiceCell
@synthesize stationDistanceLabel;
@synthesize stationImageView;
@synthesize stationNameLabel;
@synthesize stationFlag;
@synthesize orderLabel;

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
