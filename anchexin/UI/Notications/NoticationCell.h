//
//  NoticationCell.h
//  anchexin
//
//  Created by cgx on 14-8-21.
//
//

#import <UIKit/UIKit.h>

@interface NoticationCell : UITableViewCell
{
    IBOutlet UILabel *contentLabel;
    IBOutlet UILabel *titleLabel;
    
    
}

@property(nonatomic,retain)UILabel *contentLabel;
@property(nonatomic,retain)UILabel *titleLabel;

@end
