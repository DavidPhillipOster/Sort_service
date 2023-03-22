//  Created by David Phillip Oster on 3/20/2023.
//  Apache 2 License

#import "SortService.h"

#import <AppKit/AppKit.h>

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

@implementation SortService

- (void)doSortService:(NSPasteboard *)pboard userData:(NSString *)unused error:(NSString **)error {
  NSArray *classes = [NSArray arrayWithObject:[NSString class]];
  if ( ! [pboard canReadObjectForClasses:classes options:@{}]) {
    *error = NSLocalizedString(@"Error: couldn't get text.", 0);
  } else {
    NSString *pboardString = [pboard stringForType:NSPasteboardTypeString];
    int inLength = (int)[pboardString length];
    if (0 == inLength) {
      *error = NSLocalizedString(@"Error: empty string.", 0);
    } else {
      NSString *result = [self sort:pboardString error:error];
      if ([result length]) {
        [pboard clearContents];
        [pboard writeObjects:@[result]];
      }
    }
  }
}

/// Sort the string.
///  @param inString - the multi-line string to sort
///  @return a copy of the string, with the lines sorted.
- (NSString *)sort:(NSString *)inString error:(NSString **)error {
  NSString *result = nil;
  int length = (int)[inString length];
  if (length) {
    NSString *sep = Separator(inString);
    NSMutableArray *a = [[inString componentsSeparatedByString:sep] mutableCopy];
    [a sortUsingSelector:@selector(caseInsensitiveCompare:)];
    result = [a componentsJoinedByString:sep];
  }
  if (0 == [result length]) {
    *error = NSLocalizedString(@"Error: Couldn't sort.", 0);
  }
  return result;
}

@end
