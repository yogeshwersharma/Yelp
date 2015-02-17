//
//  FilterCell.m
//  Yelp
//
//  Created by Yogi Sharma on 2/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "FilterCell.h"

@interface FilterCell()
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;
- (IBAction)onValueChange:(id)sender;

@end

@implementation FilterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    [self.toggleSwitch setOn:on animated:animated];
    _on = on;
}

- (IBAction)onValueChange:(id)sender {
    NSLog(@"switch value changed");
    [self.delegate filterCell:self didChangeValue:self.toggleSwitch.on];
}
@end
