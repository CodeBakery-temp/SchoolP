#import <Foundation/Foundation.h>

@class User;

@interface ScheduleService : NSObject

+(id)schedule;
+(id)createSchedule;
-(id)initSchedule;

-(NSArray*)getLecturesOfWeek: (User*)user
                    lectures: (NSArray *)lectures
                 currentWeek: (NSUInteger)currentWeek;

-(NSDictionary*)getLecturesPerDays:(NSArray *)lectures;

-(NSDictionary*)getLecturesWithVersion:(NSDictionary*)lectures;

-(NSDictionary*)getLecturesPerDaysRefined:(NSArray*)lectures;

-(NSSet*)getLecturesOfDay: (User*)user;

-(NSArray*)getNotesOfWeek: (User*)user
                    notes: (NSArray *)notes
              currentWeek: (NSUInteger)currentWeek;

-(NSDictionary*)getNotesPerDays:(NSArray *)notes;

// TEST
-(void)updateLectureTemplate:(NSString*)courseID 
                    lectures:(NSArray*) lectures 
                    jsonPath:(NSString*)jsonPath;

-(void)updateLectureEvent:(NSString*)courseID 
                  version:(NSString*)version 
                 lectures:(NSArray*) lectures 
                 jsonPath:(NSString*)jsonPath;

// APP
-(void)updateLectureTemplate:(id)lecture;

-(void)updateLectureEvent:(id)lecture;

-(void)printLecturesWithNotes:(NSDictionary*)lectures 
                        notes:(NSDictionary*)notes;

-(void)printWeek:(NSDictionary*) lecturesWeek;

@end
