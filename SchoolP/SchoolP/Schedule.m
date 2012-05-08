#import "Schedule.h"

@implementation Schedule


@synthesize today = _today;

-(void) schedule
{
    NSDate *now = [NSDate date];
    // Specify which units we would like to use
    unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:units fromDate:now];
    
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    
    NSLog(@"year: %lu month: %lu day: %lu", year, month, day);
    
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",self.schedule];
}





@end
