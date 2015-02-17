//
//  SortByCell.m
//  Yelp
//
//  Created by Yogi Sharma on 2/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "SortByCell.h"

@interface SortByCell() <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSArray *pickerEntries;

@end

@implementation SortByCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.pickerEntries = @[@"Best Match",
                           @"Distance",
                           @"Rating",
                           @"Most Reviewed"];

    self.picker.delegate = self;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerEntries.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerEntries[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"selected row %ld, component %ld", row, component);
    [self.delegate sortByCell:self selectedValue:row];
}

@end
