#import <Foundation/Foundation.h>

@interface DBService : NSObject

+(id)database;
+(id)createDatabase;
-(id)initDatabase;

-(NSDictionary*) getUsers;
-(NSMutableArray*) getLectures;
-(NSDictionary*) getNotifications;

@end
