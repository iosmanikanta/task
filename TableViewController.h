//
//  TableViewController.h
//  task
//
//  Created by Student on 24/10/16.
//  Copyright © 2016 webpatashala. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
#import "ViewController.h"
@interface TableViewController : UITableViewController <UISearchResultsUpdating>
@property MKMapView *mapView;
@property id <HandleMapSearch>handleMapSearchDelegate;

@property NSMutableArray * array,*citiesNames;
@end
