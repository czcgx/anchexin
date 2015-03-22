//
//  BussinessCell.h
//  WisdomParking
//
//  Created by cgx on 15-1-12.
//  Copyright (c) 2015年 cgx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BussinessCell : UITableViewCell
{
    IBOutlet UIView *headView;
    IBOutlet UIView *bussinessInfoView;
    
    IBOutlet UILabel *shopNameLabel;
    
    
}
@property(nonatomic,retain)UIView *headView;
@property(nonatomic,retain)UIView *bussinessInfoView;
@property(nonatomic,retain)UILabel *shopNameLabel;

@end
