//
//  Business.m
//  Yelp
//
//  Created by Yogi Sharma on 2/11/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "Business.h"

@implementation Business

- (id)initWithDictionary:(NSDictionary *)businessDict {
    self = [super init];
    if (self) {
        // NSLog(@"business dict: %@", businessDict);
        self.imageUri = businessDict[@"image_url"];
        self.name = businessDict[@"name"];
        self.ratingImageUri = businessDict[@"rating_img_url"];
        self.numReviews = [businessDict[@"review_count"] integerValue];
        
        NSArray *streetsArray = [businessDict valueForKeyPath:@"location.address"];
        NSString *street = streetsArray.count > 0 ? streetsArray[0] : @"Unknown";
        NSArray *neighborhoodsArray = [businessDict valueForKeyPath:@"location.neighbhorhoods"];
        NSString *neighborhood = neighborhoodsArray.count > 0 ? neighborhoodsArray[0] : @"Unknown";
        self.address = [NSString stringWithFormat:@"%@, %@", street, neighborhood];
    
        NSArray *categories = businessDict[@"categories"];
        
        NSMutableArray *categoryNames = [[NSMutableArray alloc] init];
        for (NSArray *catArray in categories) {
            [categoryNames addObject:(catArray[0])];
        }
        self.categories = [categoryNames componentsJoinedByString:@", "];
        float milesPerMeter = 0.000625;
        self.distance = [businessDict[@"distance"] floatValue] * milesPerMeter;
    }
    return self;
}

+ (NSArray *)businessesArrayFromRawArray:(NSArray *)businessesRawArray {
    NSMutableArray *businessesArray = [NSMutableArray array];
    for (NSDictionary *businessDict in businessesRawArray) {
        Business *business = [[Business alloc] initWithDictionary:businessDict];
        [businessesArray addObject:business];
        // NSLog(@"deserialized another one: %ld", businessesArray.count);
    }
    return businessesArray;
}

@end
