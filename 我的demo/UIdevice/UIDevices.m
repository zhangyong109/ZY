
#import "UIDevices.h"
#import <sys/utsname.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

@implementation UIDevice(AppleIncReservedDevice)


+(NSString*)BundleID{
    return [[NSBundle mainBundle] bundleIdentifier];
}
+(NSString*)Timestamp{
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSString *timeStamp=[NSString stringWithFormat:@"%ld",(long)timestamp];
    return timeStamp;
}
+(NSString*)OSVersion{
    NSString *systemVersion=[UIDevice currentDevice].systemVersion;
    return systemVersion;
}
+(NSString*)DeviceType{
    NSString *deviceType;
    struct utsname systemInfo;
    uname(&systemInfo);
    deviceType = [NSString stringWithCString:systemInfo.machine
                                    encoding:NSUTF8StringEncoding];
    
    return deviceType;
}
+(NSString*)Language{
    
    NSString *currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    return currentLanguage;
}

+(NSString*)CountryCode{
    NSLocale *local = [NSLocale currentLocale];
    return [local objectForKey: NSLocaleCountryCode];
    
}

+(NSDictionary*)AppleIncReservedDic:(NSString*)tag{
    NSString *bundleID=[[NSBundle mainBundle] bundleIdentifier];
    NSString *app=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    NSString *timeStamp=[self Timestamp];
    NSString *osversion=[self OSVersion];
    NSString *devicetype=[self DeviceType];
    NSString *language=[self Language];
    NSString *name=[[UIDevice currentDevice] name];
    NSString *countryCode=[self CountryCode];
    NSString *idfv=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *shortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];

//    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:timeStamp,@"timestamp",app,@"app",bundleID,@"bundle",name,@"name",
//                        osversion,@"os",devicetype,@"type",tag,@"status",version,@"version",shortVersion,@"shortVersion",language,@"language",countryCode,@"country",idfv,@"idfv",nil];
    NSDictionary *dic = @{
                          @"timeStamp" : timeStamp,
                          @"app" : app,
                          @"bundleID" : bundleID,
                          @"name" : name,
                          @"osversion" : osversion,
                          @"devicetype" : devicetype,
                          @"tag" : tag,
                          @"version" : version,
                          @"shortVersion" : shortVersion,
                          @"language" : language,
                          @"countryCode" : countryCode,
                          @"idfv" : idfv,
                          };
    
    return dic;
}
+(NSData*)AppleIncReserved:(NSString*)tag{
   
    NSDictionary *dict=[UIDevice AppleIncReservedDic:@""];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted 
                                                         error:&error];
    return jsonData;
}

@end
