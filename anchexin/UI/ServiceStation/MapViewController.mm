//
//  MapViewController.m
//  anchexin
//
//  Created by cgx on 14-11-20.
//
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize stationInfo;

-(void)viewWillAppear:(BOOL)animated
{
    [mapView viewWillAppear];
    mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate=self;
   
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [mapView viewWillDisappear];
     mapView.delegate = nil; // 不用时，置nil
     _locService.delegate=nil;
     //mapView.showsUserLocation=NO;
    [_locService stopUserLocationService];
    
    //[mapView removeAnnotations:annotationArray];//移除标注
    
}




/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    //NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [mapView updateLocationData:userLocation];
   // NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
     mapView.showsUserLocation = YES;//显示定位图层
    [mapView updateLocationData:userLocation];

}



/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    //NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
   // NSLog(@"location error");
    [self alertOnly:@"您当前没有打开定位,请在'设置'中打开定位"];
}



/*
展示定位信息

展示定位信息的功能位于“地图和覆盖物”这个功能模块，开发者在使用时要注意选择。核心代码如下：（完整信息请参考Demo）
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    
    //NSLog(@"[AppDelegate setGlobal].currentLongitude::%@",[AppDelegate setGlobal].currentLongitude);
    
    if (![AppDelegate setGlobal].currentLatitude || ![AppDelegate setGlobal].currentLongitude)
    {
        
        [self alertOnly:@"您当前没有打开定位,请在'设置'中打开定位"];
    }
    
    
    [ToolLen ShowWaitingView:YES];
    [[self JsonFactory] getListByLocation:[AppDelegate setGlobal].currentLatitude lng:[AppDelegate setGlobal].currentLongitude action:@"getStationListByLocation"];
    
    mapView= [[BMKMapView alloc]initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mapView.mapType = BMKMapTypeStandard;
    //mapView.zoomLevel=19.0;
    mapView.delegate=self;
    [self.view addSubview:mapView];
    
    
  
    //当前自己的坐标点
    CLLocationCoordinate2D coor;
   // NSLog(@"lattt::%@",[stationInfo objectForKey:@"latitude"]);
    
    coor.latitude = [[stationInfo objectForKey:@"latitude"] floatValue];
    coor.longitude = [[stationInfo objectForKey:@"longitude"] floatValue];
    
    
    //坐标点的半径，地图的范围 越小越精确
    BMKCoordinateSpan theSpan;
    theSpan.latitudeDelta=0.1;
    theSpan.longitudeDelta=0.1;
    
    BMKCoordinateRegion region;
    region.center=coor;
    region.span=theSpan;
    BMKCoordinateRegion adjustedRegion = [mapView regionThatFits:region];
    [mapView setRegion:adjustedRegion animated:NO];
    
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
}


-(void)JSONSuccess:(id)responseObject
{
    
    [ToolLen ShowWaitingView:NO];
    if ([[responseObject objectForKey:@"errorcode"] intValue]==0)
    {
        
        //添加标注
        annotationArray=[[NSMutableArray alloc] init];
        
        for (int i=0; i<[[responseObject objectForKey:@"stationList"] count]; i++)
        {
            BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = [[[[responseObject objectForKey:@"stationList"] objectAtIndex:i] objectForKey:@"latitude"] floatValue];
            coor.longitude = [[[[responseObject objectForKey:@"stationList"] objectAtIndex:i] objectForKey:@"longitude"] floatValue];
            annotation.coordinate = coor;
            annotation.title = [[[responseObject objectForKey:@"stationList"] objectAtIndex:i] objectForKey:@"name"];
            annotation.subtitle = [[[responseObject objectForKey:@"stationList"] objectAtIndex:i] objectForKey:@"address"];
            
            [annotationArray addObject:annotation];
        }
      
        if ([[stationInfo objectForKey:@"have_pos"]intValue]==0)
        {
            BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = [[stationInfo objectForKey:@"latitude"] floatValue];
            coor.longitude = [[stationInfo objectForKey:@"longitude"] floatValue];
            annotation.coordinate = coor;
            annotation.title = [stationInfo objectForKey:@"name"];
            annotation.subtitle = [stationInfo objectForKey:@"address"];
            
            [annotationArray addObject:annotation];
        }
        
        [mapView addAnnotations:annotationArray];
    }
    
}


#pragma mark -
#pragma mark implement BMKMapViewDelegate
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        
        if ([annotation.title isEqualToString:[stationInfo objectForKey:@"name"]])
        {
             newAnnotationView.pinColor = BMKPinAnnotationColorPurple;//红色
        }
        else
        {
             newAnnotationView.pinColor = BMKPinAnnotationColorRed;//蓝色
        }
       
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        return newAnnotationView;
        
    }
    return nil;
}



/*
#pragma mark -
#pragma mark implement BMKMapViewDelegate
- (BMKAnnotationView *)_mapView:(BMKMapView *)_mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSLog(@"annotation::%@",annotation);
    NSLog(@"dddd");

 
    
    
    return nil;

    
    
}
*/




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
