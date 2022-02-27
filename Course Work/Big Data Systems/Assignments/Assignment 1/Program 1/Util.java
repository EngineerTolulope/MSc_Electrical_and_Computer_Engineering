import java.util.Calendar;
import java.util.GregorianCalendar;

public class Util {

	public static void main(String args[]) {
		String date="2013-05-21 13:26:56";
		System.out.println(dateStr2IntMiSeconds(date));
		
	}
	
    public static long dateStr2IntMiSeconds(String str) {
		
		Calendar cal = new GregorianCalendar();
		String yrStr = str.substring(0,4);
		String monStr = str.substring(5,7);
		String dayStr = str.substring(8,10);
		
		String hourStr = str.substring(11,13);
		String minStr = str.substring(14,16);
		String secStr = str.substring(17,19);
		
		try {
			int yr = Integer.parseInt(yrStr);
			int mon = Integer.parseInt(monStr);
			int day = Integer.parseInt(dayStr);
			int hour = Integer.parseInt(hourStr);
			int min = Integer.parseInt(minStr);
			int sec = Integer.parseInt(secStr);
			
			cal.set(yr, mon, day, hour, min, sec);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return cal.getTimeInMillis();
	}
}
