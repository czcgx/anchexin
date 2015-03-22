//
//  ProductPackageCell.m
//  anchexin
//
//  Created by cgx on 14-12-12.
//
//

#import "ProductPackageCell.h"

@implementation ProductPackageCell
@synthesize upView;
@synthesize selectedImg;
@synthesize productNameLabel;
@synthesize productPriceLabel;
@synthesize downView;
@synthesize upLineLabel;
@synthesize selectedBtn;
@synthesize downLineLabel;
@synthesize desLabel;
@synthesize detailLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
