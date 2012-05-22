#import "Message.h"

@implementation Message {
    NSMutableArray *allReceivers;
}

@synthesize sender = _sender;
@synthesize text = _text;
// receiver

+(id)messageWithSender:(NSString *)sender 
              receiver:(NSArray *)receiver 
                  text:(NSString *)text {
    return [[self alloc]initMessageWithSender:sender
                                     receiver:receiver
                                         text:text];
}

-(id)initMessageWithSender:(NSString *)sender 
                  receiver:(NSArray *)receiver 
                      text:(NSString *)text {
    if(self = [super init]) {
        allReceivers = [NSMutableArray array];
        for (NSDictionary *object in receiver) {
            [allReceivers addObject:object];
        }
        _sender = sender;
        _text = text;
        
    }
    return self;
}

-(NSMutableArray *)receiver {
    return allReceivers;
}

@end
