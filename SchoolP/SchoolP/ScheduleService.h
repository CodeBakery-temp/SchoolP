#import <Foundation/Foundation.h>

@interface ScheduleService : NSObject

+(id)schedule;
+(id)createSchedule;
-(id)initSchedule;

-(NSArray*)getLecturesOfWeek: (id)user
                    lectures: (NSArray *)lectures
                 currentWeek: (NSUInteger)currentWeek;

/*-(NSArray*)getLecturesOfDay: (id)user 
                   lectures: (NSArray *)lectures
                currentWeek: (NSUInteger)currentWeek;*/

-(NSDictionary*)getLecturesPerDays:(NSArray *)lectures;

-(void)printWeek:(NSDictionary*) lecturesWeek;

@end
