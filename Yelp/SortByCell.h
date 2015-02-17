//
//  SortByCell.h
//  Yelp
//
//  Created by Yogi Sharma on 2/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SortByCell;

@protocol SortByCellDelegate <NSObject>

- (void)sortByCell:(SortByCell *)sortByCell selectedValue:(NSInteger)value;

@end

@interface SortByCell : UITableViewCell

@property (strong, nonatomic) id<SortByCellDelegate> delegate;

@end
