//
//  TableViewController.m
//  task
//
//  Created by Student on 24/10/16.
//  Copyright © 2016 webpatashala. All rights reserved.
//

#import "TableViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
@interface TableViewController ()
{
    AppDelegate *AD;
}
@property NSArray<MKMapItem *> *matchingItems;

@end

@implementation TableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    AD=[[UIApplication sharedApplication]delegate];
    _array=[[NSMutableArray  alloc]init];
    // _citiesNames=[[NSMutableArray  alloc]init];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController;
{
    NSString *searchBarText = searchController.searchBar.text;
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = searchBarText;
    request.region = _mapView.region;
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        self.matchingItems = response.mapItems;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_matchingItems count];
}

- (NSString *)parseAddress:(MKPlacemark *)selectedItem {
    // put a space between "4" and "Melrose Place"
    NSString *firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? @" " : @"";
    // put a comma between street and city/state
    NSString *comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? @", " : @"";
    // put a space between "Washington" and "DC"
    NSString *secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? @" " : @"";
    NSString *addressLine = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",
                             (selectedItem.subThoroughfare == nil ? @"" : selectedItem.subThoroughfare),
                             firstSpace,
                             (selectedItem.thoroughfare == nil ? @"" : selectedItem.thoroughfare),
                             comma,
                             // city
                             (selectedItem.locality == nil ? @"" : selectedItem.locality),
                             secondSpace,
                             // state
                             (selectedItem.administrativeArea == nil ? @"" : selectedItem.administrativeArea)
                             ];
    return addressLine;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    MKPlacemark *selectedItem = _matchingItems[indexPath.row].placemark;
    cell.textLabel.text = selectedItem.name;
    
    cell.detailTextLabel.text = [self parseAddress:selectedItem];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKPlacemark *selectedItem = _matchingItems[indexPath.row].placemark;
    [_handleMapSearchDelegate dropPinZoomIn:(selectedItem)];
    
   AD.latitude=[NSString stringWithFormat:@"%f",selectedItem.coordinate.latitude];
  AD.longitude=[NSString stringWithFormat:@"%f",selectedItem.coordinate.longitude];
    
    [AD.citiesNames1 addObject:selectedItem.name];

    [AD.array addObject:selectedItem];
        
    [self dismissViewControllerAnimated:YES completion:^{
        ViewController *vc=[[ViewController alloc]init];
        vc.myView.hidden=YES;
    }];
    
    }
@end
