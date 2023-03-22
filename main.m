//  Created by David Phillip Oster on 3/20/2023.
//  Apache 2 License

#import <AppKit/AppKit.h>

#import "SortService.h"

int main(int argc, char *argv[]) {
  @autoreleasepool {
    SortService *service = [[SortService alloc] init];
    NSRegisterServicesProvider(service, @"SortService");
    [[NSRunLoop currentRunLoop] run];
  }
  return 0;
}
