
//  Created by Cloud Pioneers.
//  Copyright (c) 2016 Cloud Pioneers.. All rights reserved.
//

#import “CitiesViewController.h"

@interface CitiesViewController ()

-(void)doFirst;
-(void)doSomething;
@end

@implementation CitiesViewController


@synthesize citiesLabel;
@synthesize citiesName;

NSArray *cities;
NSArray *name;
NSDictionary *greeting;

NSString *urllink=@"http://localhost:58080/cloudpioneers/Product/ProductLaunch/";


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)doFirst{
    NSString *value= citiesName;
    NSString *link=[urllink stringByAppendingString:value];
    
    
    NSURL *url = [NSURL URLWithString:link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         
         if (data.length > 0 && connectionError == nil)
         {
             
             
             
             
             greeting = [NSJSONSerialization JSONObjectWithData:data
                                                        options:0
                                                          error:NULL];
             
             name = [greeting objectForKey:@"top10Cities"];
             NSLog(@"%@cities", name);
            
             
             [self doSomething];
             
         }
     }];
    
    
    
}
- (void)doSomething{
    
    
    [self.cityList reloadData];
    cities = [NSArray arrayWithArray:name];
    [self.cityList reloadData];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self doFirst];
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSInteger)tableView:(UITableView *)cityList numberOfRowsInSection:(NSInteger)section
{
    return [cities count];
}
- (UITableViewCell *)tableView:(UITableView *)cityList cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cityList";
    
    UITableViewCell *cell = [cityList dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [cities objectAtIndex:indexPath.row];
    return cell;
}




@end
