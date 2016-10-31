
//  Created by Cloud Pioneers.
//  Copyright (c) 2016 Cloud Pioneers.. All rights reserved.
//

#import "ProductAnalyzerViewController.h"
#import "CitiesViewController.h"

@interface ProductAnalyzerViewController ()
-(void)doFirst;
-(void)doSecond;
@end

@implementation ProductAnalyzerViewController {
    NSArray *productlist;
}

@synthesize tableView;
NSArray *tableData;
NSArray *cArray ;
NSString *productID;
NSString *productDetails;
NSString *s1=@"hello";
NSMutableString *s2;
NSMutableArray *c1;
NSDictionary *greeting;
NSArray *ids;
NSString *d1;
NSString *d2;
NSArray *name;
NSArray *ids;
NSArray *prodIds;
NSString *rowvalue;

NSMutableArray *prods;
NSMutableArray *prodsIds;

-(void)doFirst{
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:58080/cloudpioneers/Product"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         
         if (data.length > 0 && connectionError == nil)
         {
             
             
             prods=[NSMutableArray new];
             prodsIds = [NSMutableArray new];
             NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"%@jsonString ", jsonString);
             NSError *error2 = nil;
             
             NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error2];
             
             //int resize = (sizeof(result))/(sizeof(result[0]));
             
               NSLog(@"Number of Products: %lu", (unsigned long)result.count);
             
             for(int i=0;i<result.count;i++)
             {
                 NSDictionary *dict1 = result[i];
                
                 
                 NSString *prodId = [dict1 objectForKey:@"productId"];
                 NSString *prodLnc = [dict1 objectForKey:@"productLanchDate"];
                 NSString *prodNam = [dict1 objectForKey:@"productName"];
                 
                 [prods addObject:prodId];
                 [prodsIds addObject:prodNam];
                 
                 
             }
             
             NSLog(@"%@product mutable array", prods);
             NSLog(@"%@product mutable array", prodsIds);
             
             
             
             
             NSArray *items = [jsonString componentsSeparatedByString:@","];
             
             //NSLog(@"%@int array ", items);
             
             greeting = [NSJSONSerialization JSONObjectWithData:data
                                                        options:0
                                                          error:NULL];
             
           @"%@", ids);
             
              [self doSecond];
         }
     }];
    
    
}
-(void)doSecond{
    
    [self.tableView reloadData];
    productlist=[NSArray arrayWithArray:prodsIds];
    [self.tableView reloadData];
    ids=[NSArray arrayWithArray:prods];
    [self.tableView reloadData];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize table data
    [self doFirst];

}



- (void)viewDidUnload
{
    [super viewDidUnload];
    

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [productlist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [productlist objectAtIndex:indexPath.row];
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSInteger row=[indexPath row];
        if(row==0){
            CitiesViewController *destViewController = segue.destinationViewController;
            destViewController.citiesName =[[ids objectAtIndex:row] stringValue];
        }else if(row==1){
            
            CitiesViewController *destViewController = segue.destinationViewController;
            destViewController.citiesName = [[ids objectAtIndex:row] stringValue];

        }else{
            CitiesViewController *destViewController = segue.destinationViewController;
            destViewController.citiesName = [[ids objectAtIndex:0] stringValue];
        }
     
        
        
        
    }
}



- (IBAction)update:(id)sender {
    NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    
    NSURL* URL = [NSURL URLWithString:@"http://localhost:58080/cloudpioneers/Product/create"];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    
    request.HTTPMethod = @"POST";
    
    NSDictionary* bodyParameters = @{
                                     @"productName":@"Teddy",
                                     @"productCategoryName":@"Toys",
                                     @"productLanchDate":@"Tue Oct 20 11:54:57 PDT 2016"
                                     };
    request.HTTPBody = [NSStringFromQueryParameters(bodyParameters) dataUsingEncoding:NSUTF8StringEncoding];
    
    /* Start a new Task */
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            // Success
            NSLog(@"URL Session Task Succeeded: HTTP %ld", (long)((NSHTTPURLResponse*)response).statusCode);
        }
        else {
            // Failure
            NSLog(@"URL Session Task Failed: %@", [error localizedDescription]);
        }
    }];
    [task resume];
    
    
}
static NSString* NSStringFromQueryParameters(NSDictionary* queryParameters)
{
    NSMutableArray* parts = [NSMutableArray array];
    [queryParameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *part = [NSString stringWithFormat: @"%@=%@",
                          [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding],
                          [value stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
                          ];
        [parts addObject:part];
    }];
    return [parts componentsJoinedByString: @"&"];
}
static NSURL* NSURLByAppendingQueryParameters(NSURL* URL, NSDictionary* queryParameters)
{
    NSString* URLString = [NSString stringWithFormat:@"%@?%@",
                           [URL absoluteString],
                           NSStringFromQueryParameters(queryParameters)
                           ];
    return [NSURL URLWithString:URLString];
}




- (IBAction)Refresh:(id)sender {
    [self doFirst];
}
@end
