// SBTProxyStubResponse.h
//
// Copyright (C) 2016 Subito.it S.r.l (www.subito.it)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#if DEBUG
    #ifndef ENABLE_UITUNNEL 
        #define ENABLE_UITUNNEL 1
    #endif
#endif

#if ENABLE_UITUNNEL

#import "SBTProxyStubResponse.h"

@interface SBTProxyStubResponse()

@property (nonnull, nonatomic, strong) NSData *data;
@property (nonnull, nonatomic, strong) NSDictionary<NSString *, NSString *> *headers;
@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, assign) NSTimeInterval responseTime;
@property (nonatomic, assign) NSInteger failureCode;

@end

@implementation SBTProxyStubResponse

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.data = [decoder decodeObjectForKey:NSStringFromSelector(@selector(data))];
        self.headers = [decoder decodeObjectForKey:NSStringFromSelector(@selector(headers))];
        self.statusCode = [decoder decodeIntegerForKey:NSStringFromSelector(@selector(statusCode))];
        self.responseTime = [decoder decodeDoubleForKey:NSStringFromSelector(@selector(responseTime))];
        self.failureCode = [decoder decodeIntegerForKey:NSStringFromSelector(@selector(failureCode))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.data forKey:NSStringFromSelector(@selector(data))];
    [encoder encodeObject:self.headers forKey:NSStringFromSelector(@selector(headers))];
    [encoder encodeInteger:self.statusCode forKey:NSStringFromSelector(@selector(statusCode))];
    [encoder encodeDouble:self.responseTime forKey:NSStringFromSelector(@selector(responseTime))];
    [encoder encodeInteger:self.failureCode forKey:NSStringFromSelector(@selector(failureCode))];
}

+ (SBTProxyStubResponse *)responseWithData:(NSData*)data headers:(NSDictionary<NSString *, NSString *> *)headers statusCode:(NSUInteger)statusCode responseTime:(NSTimeInterval)responseTime
{
    SBTProxyStubResponse *ret = [[SBTProxyStubResponse alloc] init];
    
    ret.data = data;
    ret.headers = headers;
    ret.statusCode = statusCode;
    ret.responseTime = responseTime;
    ret.failureCode = 0;
    
    return ret;
}

+ (SBTProxyStubResponse *)failureWithCustomErrorCode:(NSInteger)code responseTime:(NSTimeInterval)responseTime;
{
    SBTProxyStubResponse *ret = [[SBTProxyStubResponse alloc] init];
    
    ret.data = [[NSData alloc] init];
    ret.headers = @{};
    ret.statusCode = 0;
    ret.responseTime = responseTime;
    ret.failureCode = code;
    
    return ret;
}

- (NSString *)description
{
    if (self.failureCode != 0) {
        return [NSString stringWithFormat:@"Failure code %lu", self.failureCode];
    } else {
        return [NSString stringWithFormat:@"data-length: %lu\nstatusCode: %lu\nresponseTime: %.2f\nheaders: %@", (unsigned long)self.data.length, (unsigned long)self.statusCode, self.responseTime, self.headers];
    }
}

@end

#endif
