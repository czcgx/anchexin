//
//  ModifyCell.m
//  anchexin
//
//  Created by cgx on 14-8-28.
//
//

#import "ModifyCell.h"

@implementation ModifyCell
@synthesize nameLabel;
@synthesize editLabel;
@synthesize lineLabel;
@synthesize sendView;
@synthesize inputTextField;
@synthesize  sendButton;

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
