//
//  CarTypeCell.h
//  AnCheXin
//
//  Created by cgx on 13-11-11.
//  Copyright (c) 2013年 LianJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarTypeCell : UITableViewCell
{
    IBOutlet UILabel *carTypeName;
    
    IBOutlet UIImageView *imageViewIcon;
    
    
}

@property(nonatomic,retain)UILabel *carTypeName;
@property(nonatomic,retain)UIImageView *imageViewIcon;

@end
