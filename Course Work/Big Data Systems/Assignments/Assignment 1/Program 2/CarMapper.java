import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;

public class CarMapper extends Mapper<LongWritable, Text, Car, Text> {

	Car car = new Car();
	//private NullWritable nullValue = NullWritable.get();
	//private static final int MISSING = 9999;

	@Override
    public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
        String datalist[] = value.toString().split(",");
        int vehicleid = Integer.parseInt(datalist[0]);
        //String longitude = datalist[1], latitude = datalist[2];
        long timemilli = Util.dateStr2IntMiSeconds(datalist[5]);
        Text velocity = new Text("Velocity="+datalist[4]);
        //
        car.setVehicleid(vehicleid);
        car.setTime(timemilli);
        //
        //String carlocation = longitude + "," + latitude; 
		//
		context.write(car, velocity);
        
    }
}