//
//  ProductPackageCell.h
//  anchexin
//
//  Created by cgx on 14-12-12.
//
//

#import <UIKit/UIKit.h>

@interface ProductPackageCell : UITableViewCell
{
    IBOutlet UIView *upView;
    IBOutlet UIButton *selectedBtn;
    IBOutlet UILabel *upLineLabel;
    IBOutlet UILabel *downLineLabel;
    IBOutlet UIImageView *selectedImg;
    IBOutlet UILabel *productNameLabel;
    IBOutlet UILabel *productPriceLabel;
    IBOutlet UIView *downView;
    
    IBOutlet UILabel *desLabel;
    IBOutlet UILabel *detailLabel;
    
}

@property(nonatomic,retain)UIView *upView;
@property(nonatomic,retain)UIButton *selectedBtn;

@property(nonatomic,retain)UILabel *upLineLabel;
@property(nonatomic,retain)UIImageView *selectedImg;
@property(nonatomic,retain)UILabel *productNameLabel;
@property(nonatomic,retain)UILabel *productPriceLabel;
@property(nonatomic,retain)UIView *downView;
@property(nonatomic,retain)UILabel *downLineLabel;
@property(nonatomic,retain)UILabel *desLabel;
@property(nonatomic,retain)UILabel *detailLabel;

@end
