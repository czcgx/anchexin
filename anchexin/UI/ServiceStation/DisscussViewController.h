//
//  DisscussViewController.h
//  anchexin
//
//  Created by cgx on 14-9-16.
//
//

#import "BaseViewController.h"
#import "TQStarRatingView.h"

@interface DisscussViewController : BaseViewController<UITextViewDelegate,StarRatingViewDelegate>
{
    UITextView *commentTextView;
    int upscore;
    
}

@property(nonatomic,retain)NSString *stationId;

@end
