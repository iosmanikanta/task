//
//  ViewController.h
//  task
//
//  Created by Student on 24/10/16.
//  Copyright © 2016 webpatashala. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@protocol HandleMapSearch <NSObject>
- (void)dropPinZoomIn:(MKPlacemark *)placemark;


@end

@interface ViewController : UIViewController <CLLocationManagerDelegate, HandleMapSearch, MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *getBtn;

@property (strong, nonatomic) IBOutlet UILabel *latititudeLbl;
@property (strong, nonatomic) IBOutlet UILabel *longitudeLbl;
- (IBAction)get:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *myView;


@end

