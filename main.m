//  Created by David Phillip Oster on 3/20/2023.
//  Apache 2 License

#import <AppKit/AppKit.h>

#import "SortService.h"
#import "SortWork.h"

// uncomment next line to run tests.
//#define TESTING 1
#if TESTING
void Tests(void){
  NSString *s = @"B\nA\nC\n";
  NSString *golden = @"A\nB\nC\n";
  NSString *result = SortStringWithErrorString(s, NULL);
  assert([result isEqual:golden]);
  s = @"B\n\nA\n\nC\n\n";
  golden = @"A\n\nB\n\nC\n\n";
  result = SortStringWithErrorString(s, NULL);
  assert([result isEqual:golden]);
  s = @"B\n\nA\n\nC";
  golden = @"A\n\nB\n\nC";
  result = SortStringWithErrorString(s, NULL);
  assert([result isEqual:golden]);
  s = @"B";
  golden = @"B";
  result = SortStringWithErrorString(s, NULL);
  assert([result isEqual:golden]);
}
#endif


int main(int argc, char *argv[]) {
  @autoreleasepool {
#if TESTING
    Tests();
#endif
    SortService *service = [[SortService alloc] init];
    NSRegisterServicesProvider(service, @"SortService");
    [[NSRunLoop currentRunLoop] run];
  }
  return 0;
}
