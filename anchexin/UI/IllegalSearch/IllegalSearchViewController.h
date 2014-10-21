//
//  IllegalSearchViewController.h
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "BaseViewController.h"
#import "IllegalListViewController.h"

@interface IllegalSearchViewController : BaseViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate>
{
    UIActionSheet *actionSheet;
    UIPickerView *picker;
    
    UITextField *txt1;
    UITextField *txt2;
    UITextField *txt3;
    UITextField *txt4;
    
    NSArray *proviceArray;
    NSDictionary *cityDic;
    
    NSDictionary *dic;
    
    NSArray *searchArray;
}




@end
