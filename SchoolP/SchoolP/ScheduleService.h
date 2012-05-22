#import <Foundation/Foundation.h>

@interface ScheduleService : NSObject

+(id)schedule;
+(id)createSchedule;
-(id)initSchedule;

-(NSArray*)getLecturesOfWeek: (id)user
                    lectures: (NSArray *)lectures
                 currentWeek: (NSUInteger)currentWeek;

-(NSDictionary*)getLecturesPerDays:(NSArray *)lectures;

-(NSSet*)getLecturesOfDay: (id)user;

-(NSArray*)getNotesOfWeek: (id)user
                    notes: (NSArray *)notes
              currentWeek: (NSUInteger)currentWeek;

-(NSDictionary*)getNotesPerDays:(NSArray *)notes;

-(void)printLecturesWithNotes:(NSDictionary*)lectures notes:(NSDictionary*)notes;

-(void)printWeek:(NSDictionary*) lecturesWeek;

@end
