//
//  MapViewController.h
//  anchexin
//
//  Created by cgx on 14-11-20.
//
//

#import "BaseViewController.h"
#import "BMapKit.h"

@interface MapViewController : BaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView  *mapView;
    BMKLocationService *_locService;
    
    NSMutableArray * annotationArray;
    
}

@property(nonatomic,retain)NSDictionary *stationInfo;

@end
