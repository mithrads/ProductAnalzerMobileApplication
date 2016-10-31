
//  Created by Cloud Pioneers.
//  Copyright (c) 2016 Cloud Pioneers.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductAnalyzerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 

@property (weak, nonatomic) IBOutlet UITextField *newproduct;
@property (weak, nonatomic) IBOutlet UITextField *newcategory;
- (IBAction)Refresh:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *category;

- (IBAction)update:(id)sender;

@property (nonatomic, strong) IBOutlet UITableView *tableView;


@end
