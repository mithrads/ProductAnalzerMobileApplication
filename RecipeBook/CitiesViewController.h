
//  Created by Cloud Pioneers.
//  Copyright (c) 2016 Cloud Pioneers.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitiesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *citiesLabel;

@property (weak, nonatomic) IBOutlet UITableView *cityList;
@property (nonatomic, strong) NSString *citiesName;

@end
