//
//  Station5Cell.h
//  anchexin
//
//  Created by cgx on 14-12-7.
//
//

#import <UIKit/UIKit.h>

@interface Station5Cell : UITableViewCell
{
    IBOutlet UIButton *disscussBtn;
    IBOutlet UILabel *disscussNameLabel;
    IBOutlet UILabel *disscussTimeLabel;
    IBOutlet UILabel *disscussContentLabel;
    IBOutlet UIView *disscussView;
    
}

@property(nonatomic,retain)UIButton *disscussBtn;
@property(nonatomic,retain)UILabel *disscussNameLabel;
@property(nonatomic,retain)UILabel *disscussTimeLabel;
@property(nonatomic,retain)UILabel *disscussContentLabel;
@property(nonatomic,retain)UIView *disscussView;

@end
