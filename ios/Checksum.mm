#import "Checksum.h"
#include <CommonCrypto/CommonDigest.h>

@implementation Checksum
RCT_EXPORT_MODULE()

- (NSString *)getChecksumAsset:(NSString *)filePath {
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(.*)\\.(.*)" options:NSRegularExpressionCaseInsensitive error:nil];
  NSRange range = NSMakeRange(0,filePath.length);
  NSString* body = [regex stringByReplacingMatchesInString:filePath options:0 range:range withTemplate:@"$1\n$2"];
  NSArray* splitFile = [body componentsSeparatedByString:@"\n"];
  if(splitFile.count == 2){
    NSString *path = [[NSBundle mainBundle] pathForResource:splitFile[0] ofType:splitFile[1]];
    NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if (data == nil) {

      return @"";
    }
    
    const char* str = [data UTF8String];
    
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++)
    {
      [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
  }
  return @"";
  
}

- (NSString *)getBundleChecksum {
  return [self getChecksumAsset:@"main.jsbundle"];
  
}

- (NSString *)getChecksumFile: (NSString *)filePath {
  return [self getChecksumAsset:filePath];
}


- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
(const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeChecksumSpecJSI>(params);
}

@end
