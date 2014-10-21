//
//  AnalysisViewController.h
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "BaseViewController.h"
#import "AnalysisCell.h"

@interface AnalysisViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *analysisTableView;
}

@end
