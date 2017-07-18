//
//  FBHttpRequest.m
//  FamilyBaby
//
//  Created by super on 16/8/30.
//  Copyright © 2016年 super. All rights reserved.
//
//

#import "FBHttpRequest.h"

@interface FBHttpRequest ()

@end

@implementation FBHttpRequest

@synthesize session = _session;
@synthesize configuration = _configuration;

+ (instancetype)shared {
    static id __staticObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __staticObject = [self new];
    });
    return __staticObject;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        AFJSONResponseSerializer *JSONResponseSerializer = [AFJSONResponseSerializer serializer];
        JSONResponseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [[AFURLSessionManager alloc] initWithSessionConfiguration:_configuration];
       
        _session.responseSerializer = JSONResponseSerializer;
    }
    return self;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(NSDictionary *)params completionHandler:(T)completionHandler; {
    return [self dataTaskWithHTTPMethod:@"GET" URLString:URLString parameters:params completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(NSDictionary *)params completionHandler:(T)completionHandler; {
    return [self dataTaskWithHTTPMethod:@"POST" URLString:URLString parameters:params completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(NSDictionary *)params
                               completionHandler:(T)completionHandler; {
    
    NSParameterAssert(method);
    NSParameterAssert(URLString);
   
    
    
    NSURL *url = [NSURL URLWithString:URLString relativeToURL:self.baseURL];
    
    NSParameterAssert(url);
    
    NSError *error = nil;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:method
                                                                                 URLString:url.absoluteString
                                                                                parameters:params
                                                                                     error:&error];
    if (error) {
        DLog(@"%@", error);
        return nil;
    }
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error && self.errorLog) {
            DLog(@"%@", error); // http状态非200
        }
        if (responseObject && self.responseObjectLog) {
            DLog(@"%@--%@", URLString,responseObject);
        }
        if (completionHandler) {
            completionHandler(responseObject, error);
        }
        
        //异常信息统一处理,业务只需处理正确的
        //        NSInteger State = [[responseObject objectForKey:@"State"] integerValue];
        //        NSString *ErrorMessage = [responseObject objectForKey:@"ErrorMessage"];
        //        if (State == 200) { //正确的唯一码
        //
        //        }else{
        //            KS_ALERT_AFTER(ErrorMessage, 1);
        //        }
        
    }];
    [dataTask resume];
    return dataTask;
}



- (NSURLSessionUploadTask *)uploadImageArray:(NSArray *)imageArr completionHander:(T)comletionHandler{
    
    NSMutableArray *dataArr = [NSMutableArray array];
    for (UIImage *img in imageArr) {
        NSData *data = UIImagePNGRepresentation(img);
        [dataArr addObject:data];
    }
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://192.168.2.167:6001/commons/uploadfilelist" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSData *tempData in dataArr) {
            [formData appendPartWithFileData:tempData name:@"file" fileName:@"avatar.png" mimeType:@"image/png"];
        }
        
    } error:nil];
        
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          // [progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error && self.errorLog) {
                          DLog(@"%@", error);
                      }
                      if (responseObject && self.responseObjectLog) {
                          DLog(@"上传图片--%@",responseObject);
                      }
                      if (comletionHandler) {
                          comletionHandler(responseObject, error);
                      }
                      
                      //异常信息统一处理,业务只需处理正确的
                      NSInteger State = [[responseObject objectForKey:@"State"] integerValue];
                      NSString *ErrorMessage = [responseObject objectForKey:@"ErrorMessage"];
                      if (State == 200) { //正确的唯一码
                          
                      }else{
                          NSString *allErrorMassage = [NSString stringWithFormat:@"%@--%ld",ErrorMessage,State];
                          KS_ALERT_AFTER(allErrorMassage, 1);
                      }
                      
                  }];
    
    [uploadTask resume];
    return uploadTask;
}







@end
