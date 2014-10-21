//
//  VehicleDiagnosisViewController.h
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "BaseViewController.h"
#import "VehicleCell.h"

@interface VehicleDiagnosisViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *vehicleDiagnosisTableView;
    NSArray *vehicleDiagnosisArray;
    
}

@end
