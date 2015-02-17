//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "Business.h"
#import "BusinessCell.h"
#import "FiltersViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *businessesArray;
@property (nonatomic, strong) NSDictionary *filters;
@property (nonatomic, strong) NSString *searchTerm;
@property (weak, nonatomic) IBOutlet UITableView *businessesTableView;

- (void)fetchBusinessesWithQuery:(NSString *)query params:(NSDictionary *)params;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        self.searchTerm = @"Restaurants";
        [self fetchBusinessesWithQuery:self.searchTerm params:nil];
        
      }
    return self;
}

- (void)fetchBusinessesWithQuery:(NSString *)query params:(NSDictionary *)params {
    [self.client searchWithTerm:query params:params success:^(AFHTTPRequestOperation *operation, id response) {
        // NSLog(@"response from Yelp API: %@", response);
        
        NSArray *businessesRawArray = response[@"businesses"];
        NSLog(@"number of businesses returned: %ld", businessesRawArray.count);
        self.businessesArray = [Business businessesArrayFromRawArray:businessesRawArray];
        NSLog(@"number of businesses after deserialization: %ld", self.businessesArray.count);
        [self.businessesTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businessesArray.count;
    // return MIN(2, self.businessesArray.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [self.businessesTableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.business = self.businessesArray[indexPath.row];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.businessesTableView.delegate = self;
    self.businessesTableView.dataSource = self;
    
    [self.businessesTableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    self.businessesTableView.rowHeight = UITableViewAutomaticDimension;
    self.businessesTableView.estimatedRowHeight = 100;
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.barStyle = UISearchBarStyleProminent;
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;

    // self.title = @"Yelp Test";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UISearchBarDelegate methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    // NSLog(@"text did change: %@", searchText);
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"editing ended");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search button clicked: %@", searchBar.text);
    self.searchTerm = searchBar.text;
    [self fetchBusinessesWithQuery:self.searchTerm params:self.filters];
}

# pragma mark - Filters delegate methods.

- (void)filtersViewController:(FiltersViewController *)filtersViewController changedFilters:(NSDictionary *)filters {
    NSLog(@"filters changed callback in main view controller: %@", filters);
    self.filters = filters;
    [self fetchBusinessesWithQuery:self.searchTerm params:self.filters];
}

# pragma mark - Private methods

- (void)onFilterButton {
    FiltersViewController *fvc = [[FiltersViewController alloc] init];
    fvc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:fvc];
    [self presentViewController:nvc animated:YES completion:nil];
}
@end
