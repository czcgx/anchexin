//
//  Station1Cell.h
//  anchexin
//
//  Created by cgx on 14-12-7.
//
//

#import <UIKit/UIKit.h>

@interface Station1Cell : UITableViewCell
{
    IBOutlet UIImageView *shopImg;
    IBOutlet UIButton *shopBtn;
    
    IBOutlet UILabel *shopNameLabel;
    IBOutlet UILabel *shopPhoneLabel;
    IBOutlet UIButton *shopPhoneBtn;
    
    IBOutlet UILabel *shopAddressLabel;
    IBOutlet UIButton *shopAddressBtn;
    
    IBOutlet UIView *starView;
    IBOutlet UILabel *pageNumLabel;
    
}

@property(nonatomic,retain)UIImageView *shopImg;
@property(nonatomic,retain)UIButton *shopBtn;
@property(nonatomic,retain)UILabel *shopNameLabel;
@property(nonatomic,retain)UILabel *shopPhoneLabel;
@property(nonatomic,retain)UIButton *shopPhoneBtn;
@property(nonatomic,retain)UILabel *shopAddressLabel;
@property(nonatomic,retain)UIButton *shopAddressBtn;
@property(nonatomic,retain)UIView *starView;
@property(nonatomic,retain)UILabel *pageNumLabel;

@end
