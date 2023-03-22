//  SortWork.m
//
//  Created by david on 3/22/23.
//  Apache 2 License
//

#import "SortWork.h"

/// By default, use \n as the line separator.
/// If all the lines (or all but one, usually the last line) are separated with \n\n, then use \n\n for the sort line separator.
///
/// @param s the string to inspect.
/// @return the line separator for sorting.
static NSString *Separator(NSString *s) {
  NSString *sep = @"\n";
  NSUInteger len = s.length;
  NSUInteger doubleLineCount = 0;
  NSUInteger lineCount = 0;
  for (NSUInteger i = 0; i < len; ++i) {
    if ('\n' == [s characterAtIndex:i]){
      ++lineCount;
      if (i+1 < len && '\n' == [s characterAtIndex:i+1]) {
        ++i;
        ++doubleLineCount;
      }
    }
  }
  if (lineCount <= doubleLineCount+1) {
    sep = @"\n\n";
  }
  return sep;
}

static NSString *Terminator(NSString *s) {
  if (NSNotFound != [s rangeOfString:@"\n\n" options:NSBackwardsSearch|NSAnchoredSearch].location) {
    return @"\n\n";
  }
  if (NSNotFound != [s rangeOfString:@"\n" options:NSBackwardsSearch|NSAnchoredSearch].location) {
    return @"\n";
  }
  return @"";
}

/// Sort the multi-line string.
///  @param inString - the multi-line string to sort
///  @param errorp - will store an error string on error.
///  @return a copy of the string, with the lines sorted.
NSString *SortStringWithErrorString(NSString *inString, NSString **errorp) {
  NSString *result = nil;
  int length = (int)[inString length];
  if (length) {
    NSString *separator = Separator(inString);
    NSString *terminator = Terminator(inString);
    NSString *s = [inString substringToIndex:inString.length - terminator.length];
    NSMutableArray *a = [[s componentsSeparatedByString:separator] mutableCopy];
    [a sortUsingSelector:@selector(caseInsensitiveCompare:)];
    result = [[a componentsJoinedByString:separator] stringByAppendingString:terminator];
  }
  if (0 == [result length]) {
    if (nil != errorp) {
      *errorp = NSLocalizedString(@"Error: Couldn't sort.", 0);
    }
  }
  return result;
}
