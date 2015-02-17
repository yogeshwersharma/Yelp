//
//  Business.h
//  Yelp
//
//  Created by Yogi Sharma on 2/11/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject

@property(nonatomic, strong) NSString *imageUri;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *ratingImageUri;
@property(nonatomic, assign) NSInteger numReviews;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSString *categories;
@property(nonatomic, assign) CGFloat distance;

+ (NSArray *)businessesArrayFromRawArray:(NSArray *)businessesRawArray;

@end
