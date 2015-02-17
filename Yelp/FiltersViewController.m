//
//  FilterViewController.m
//  Yelp
//
//  Created by Yogi Sharma on 2/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "FiltersViewController.h"
#import "FilterCell.h"
#import "SortByCell.h"

@interface FiltersViewController () <UITableViewDataSource, UITableViewDelegate, FilterCellDelegate, SortByCellDelegate>

@property(nonatomic, readonly) NSDictionary *filters;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSMutableSet *selectedCategories;
@property (nonatomic, assign) NSInteger sortByField;

- (void)initCategories;

@end

@implementation FiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.selectedCategories = [NSMutableSet set];
        [self initCategories];
    }
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
    // 0 for sort_by
    // 1 for cuisine
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSLog(@"title for header %ld", section);
    NSString *sectionName;
    switch (section) {
        case 0:
            sectionName = NSLocalizedString(@"Sort by", @"Sort by");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Cuisine", @"Cuisine");
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"section number %ld", section);
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.categories.count;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterCell *filterCell = [[FilterCell alloc] init];
    SortByCell *sortByCell = [[SortByCell alloc] init];
    switch (indexPath.section) {
        case 0:
            sortByCell = [self.tableView dequeueReusableCellWithIdentifier:@"SortByCell"];
            sortByCell.delegate = self;
            return sortByCell;
            break;
        case 1:
            filterCell = [self.tableView dequeueReusableCellWithIdentifier:@"FilterCell"];
            filterCell.delegate = self;
            filterCell.titleLabel.text = self.categories[indexPath.row][@"name"];
            filterCell.on = [self.selectedCategories containsObject:self.categories[indexPath.row]];
            return filterCell;
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(onApplyButton)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.sortByField = 0; // default
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FilterCell" bundle:nil] forCellReuseIdentifier:@"FilterCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SortByCell" bundle:nil] forCellReuseIdentifier:@"SortByCell"];
    
    // self.tableView.rowHeight = 300;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - FilterCell delegate methods. 

- (void)filterCell:(FilterCell *)filterCell didChangeValue:(BOOL)value {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:filterCell];
    if (value) {
        [self.selectedCategories addObject:self.categories[indexPath.row]];
    } else {
        [self.selectedCategories removeObject:self.categories[indexPath.row]];
    }
}

# pragma mark - SortByCell delegate

- (void)sortByCell:(SortByCell *)sortByCell selectedValue:(NSInteger)value {
    self.sortByField = value;
    NSLog(@"sorting in filter vc by %ld", self.sortByField);
}

#pragma mark - Private methods

- (void)initCategories {
    self.categories =
    @[@{@"name": @"Afghan", @"code":@"afghani" },
        @{@"name": @"African", @"code":@"african" },
        @{@"name": @"American (New)", @"code":@"newamerican" },
        @{@"name": @"American (Traditional)", @"code":@"tradamerican" },
        @{@"name": @"Arabian", @"code":@"arabian" },
        ];
    
}

- (NSDictionary *)filters {
    NSMutableDictionary *mutableFilters = [NSMutableDictionary dictionary];
    if (self.selectedCategories.count > 0) {
        NSMutableArray *categoryCodes = [NSMutableArray array];
        for (NSDictionary *category in self.selectedCategories) {
            [categoryCodes addObject:category[@"code"]];
        }
        NSString *categoryFilter = [categoryCodes componentsJoinedByString:@","];
        [mutableFilters setObject:categoryFilter forKey:@"category_filter"];
    }
    [mutableFilters setObject:[NSString stringWithFormat:@"%ld", self.sortByField]   forKey:@"sort"];
    return mutableFilters;
}

- (void)onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onApplyButton {
    [self.delegate filtersViewController:self changedFilters:self.filters];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
