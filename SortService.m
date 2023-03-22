//  Created by David Phillip Oster on 3/20/2023.
//  Apache 2 License

#import "SortService.h"

#import "SortWork.h"
#import <AppKit/AppKit.h>


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
      NSString *result = SortStringWithErrorString(pboardString, error);
      if ([result length]) {
        [pboard clearContents];
        [pboard writeObjects:@[result]];
      }
    }
  }
}

@end
