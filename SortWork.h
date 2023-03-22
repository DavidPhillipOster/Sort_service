//  SortWork.h
//
//  Created by david on 3/22/23.
//  Apache 2 License
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Sort the multi-line string.
///  @param inString - the multi-line string to sort
///  @param errorp - will store an error string on error.
///  @return a copy of the string, with the lines sorted.
NSString *SortStringWithErrorString(NSString *inString, NSString *_Nullable * _Nullable errorp);

NS_ASSUME_NONNULL_END
