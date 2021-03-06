//
//  RHGFakeAutoadvancingCurrentDateWrapper.m
//  Phoenix
//
//  Created by Robert Gilliam on 4/16/13.
//  Copyright (c) 2013 Robert Gilliam. All rights reserved.
//

#import "RHGFakeAutoadvancingCurrentDateWrapper.h"
#import "RHGTimerWrapperNS.h"

@interface RHGFakeAutoadvancingCurrentDateWrapper ()

@property (readonly) NSDate *fakeStartDate;
@property (readonly) NSTimeInterval systemStartTimeInterval;
@property (readonly) RHGTimerWrapperNS *timerWrapper;

@end


@implementation RHGFakeAutoadvancingCurrentDateWrapper

- (id)initWithStartDate:(NSDate *)date
{
    self = [super init];
    if (!self) return nil;
    
    _fakeStartDate = date;
    _systemStartTimeInterval = [NSDate timeIntervalSinceReferenceDate];
    _timerWrapper = [[RHGTimerWrapperNS alloc] init];
    _timerWrapper.currentDateWrapper = self;
    
    return self;
}

- (id)init
{
    [NSException raise:NSInternalInconsistencyException format:@"%@: use the designated init, not %@.", [self class], NSStringFromSelector(_cmd)];
    return nil;
}

- (NSDate *)currentDate
{
    NSTimeInterval systemCurrentTimeInterval = [NSDate timeIntervalSinceReferenceDate];
    return [NSDate dateWithTimeInterval:systemCurrentTimeInterval - self.systemStartTimeInterval sinceDate:self.fakeStartDate];
}
- (NSDate *)dateForNextOccurenceOfHour:(NSInteger)hour
{
    @throw @"Not yet implemented.";
}

- (NSTimeInterval)timeUntilDate:(NSDate *)date
{
    return [date timeIntervalSinceDate:[self currentDate]];
}

- (void)callback:(id<RHGTimerWrapperDelegate>)delegate onDate:(NSDate *)theDate
{
    [[self timerWrapper] callback:delegate onDate:theDate];
}

@end
