// Software License Agreement (BSD License)
//
// Copyright (c) 2010-2016, Deusty, LLC
// All rights reserved.
//
// Redistribution and use of this software in source and binary forms,
// with or without modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//
// * Neither the name of Deusty nor the names of its contributors may be used
//   to endorse or promote products derived from this software without specific
//   prior written permission of Deusty, LLC.

#import "AWSDDContextFilterLogFormatter.h"
#import <libkern/OSAtomic.h>

#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@interface AWSDDLoggingContextSet : NSObject

- (void)addToSet:(NSUInteger)loggingContext;
- (void)removeFromSet:(NSUInteger)loggingContext;

@property (readonly, copy) NSArray *currentSet;

- (BOOL)isInSet:(NSUInteger)loggingContext;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface AWSDDContextWhitelistFilterLogFormatter () {
    AWSDDLoggingContextSet *_contextSet;
}

@end


@implementation AWSDDContextWhitelistFilterLogFormatter

- (instancetype)init {
    if ((self = [super init])) {
        _contextSet = [[AWSDDLoggingContextSet alloc] init];
    }

    return self;
}

- (void)addToWhitelist:(NSUInteger)loggingContext {
    [_contextSet addToSet:loggingContext];
}

- (void)removeFromWhitelist:(NSUInteger)loggingContext {
    [_contextSet removeFromSet:loggingContext];
}

- (NSArray *)whitelist {
    return [_contextSet currentSet];
}

- (BOOL)isOnWhitelist:(NSUInteger)loggingContext {
    return [_contextSet isInSet:loggingContext];
}

- (NSString *)formatLogMessage:(AWSDDLogMessage *)logMessage {
    if ([self isOnWhitelist:logMessage->_context]) {
        return logMessage->_message;
    } else {
        return nil;
    }
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface AWSDDContextBlacklistFilterLogFormatter () {
    AWSDDLoggingContextSet *_contextSet;
}

@end


@implementation AWSDDContextBlacklistFilterLogFormatter

- (instancetype)init {
    if ((self = [super init])) {
        _contextSet = [[AWSDDLoggingContextSet alloc] init];
    }

    return self;
}

- (void)addToBlacklist:(NSUInteger)loggingContext {
    [_contextSet addToSet:loggingContext];
}

- (void)removeFromBlacklist:(NSUInteger)loggingContext {
    [_contextSet removeFromSet:loggingContext];
}

- (NSArray *)blacklist {
    return [_contextSet currentSet];
}

- (BOOL)isOnBlacklist:(NSUInteger)loggingContext {
    return [_contextSet isInSet:loggingContext];
}

- (NSString *)formatLogMessage:(AWSDDLogMessage *)logMessage {
    if ([self isOnBlacklist:logMessage->_context]) {
        return nil;
    } else {
        return logMessage->_message;
    }
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface AWSDDLoggingContextSet () {
    OSSpinLock _lock;
    NSMutableSet *_set;
}

@end


@implementation AWSDDLoggingContextSet

- (instancetype)init {
    if ((self = [super init])) {
        _set = [[NSMutableSet alloc] init];
        _lock = OS_SPINLOCK_INIT;
    }

    return self;
}


- (void)addToSet:(NSUInteger)loggingContext {
    OSSpinLockLock(&_lock);
    {
        [_set addObject:@(loggingContext)];
    }
    OSSpinLockUnlock(&_lock);
}

- (void)removeFromSet:(NSUInteger)loggingContext {
    OSSpinLockLock(&_lock);
    {
        [_set removeObject:@(loggingContext)];
    }
    OSSpinLockUnlock(&_lock);
}

- (NSArray *)currentSet {
    NSArray *result = nil;

    OSSpinLockLock(&_lock);
    {
        result = [_set allObjects];
    }
    OSSpinLockUnlock(&_lock);

    return result;
}

- (BOOL)isInSet:(NSUInteger)loggingContext {
    BOOL result = NO;

    OSSpinLockLock(&_lock);
    {
        result = [_set containsObject:@(loggingContext)];
    }
    OSSpinLockUnlock(&_lock);

    return result;
}

@end

#pragma clang diagnostic pop
