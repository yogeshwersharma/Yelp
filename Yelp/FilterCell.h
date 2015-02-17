//
//  FilterCell.h
//  Yelp
//
//  Created by Yogi Sharma on 2/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterCell;

@protocol FilterCellDelegate <NSObject>

- (void)filterCell:(FilterCell *)filterCell didChangeValue:(BOOL)value;

@end

@interface FilterCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(weak, nonatomic) id<FilterCellDelegate> delegate;
@property(nonatomic, assign) BOOL on;

- (void)setOn:(BOOL)on animated:(BOOL)animated;


@end
