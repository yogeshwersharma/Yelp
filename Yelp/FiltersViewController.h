//
//  FilterViewController.h
//  Yelp
//
//  Created by Yogi Sharma on 2/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>

- (void)filtersViewController:(FiltersViewController *)filtersViewController changedFilters:(NSDictionary *)filters;

@end

@interface FiltersViewController : UIViewController

@property(weak, nonatomic) id<FiltersViewControllerDelegate> delegate;

@end
