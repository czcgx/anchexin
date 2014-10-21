//
//  MoreCell.m
//  anchexin
//
//  Created by cgx on 14-8-22.
//
//

#import "MoreCell.h"

@implementation MoreCell
@synthesize iconImageView;
@synthesize contentLabel;


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

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if(highlighted)
    {
        self.contentView.backgroundColor=kUIColorFromRGB(0x1c1c1c);
    }
    else
    {
        self.contentView.backgroundColor=kUIColorFromRGB(0x222222);
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
