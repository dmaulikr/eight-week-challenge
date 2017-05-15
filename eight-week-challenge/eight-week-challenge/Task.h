//
//  Task.h
//  eight-week-challenge
//
//  Created by Jake Romer on 5/15/17.
//  Copyright © 2017 Kyle Hillman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *value;
+ (instancetype) taskFromDict:(NSDictionary*)dict;
@end