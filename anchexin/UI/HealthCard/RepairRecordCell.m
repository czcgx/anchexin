//
//  RepairRecordCell.m
//  anchexin
//
//  Created by cgx on 14-8-21.
//
//

#import "RepairRecordCell.h"

@implementation RepairRecordCell
@synthesize stationName;
@synthesize stationItem;
@synthesize stationPrice;
@synthesize stationTime;

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
