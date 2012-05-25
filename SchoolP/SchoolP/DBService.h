#import <Foundation/Foundation.h>

@interface DBService : NSObject

+(id)database;
+(id)createDatabase;
-(id)initDatabase;

+(void) postToDatabase: (NSString *) urlAdress
            sourcePath: (NSString *) theSource;

+(void) lectureToDataBase: (NSDictionary *) dictionary;
<<<<<<< HEAD
+(void) notificationToDataBase: (NSDictionary *) dictionary;
=======
+(void) noteficationToDataBase: (NSDictionary *) dictionary;
+(NSString *) lecturesDB;

-(NSDictionary *) getUsers;
-(NSMutableArray *) getLectures;
-(NSDictionary *) getNotifications;
>>>>>>> Boffe Menu


@end
