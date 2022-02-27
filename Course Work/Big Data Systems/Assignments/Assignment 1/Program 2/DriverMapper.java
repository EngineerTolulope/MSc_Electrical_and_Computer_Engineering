import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import java.io.IOException;

public class DriverMapper extends Mapper<LongWritable, Text, Car, Text> {

	Car car = new Car();
	//private NullWritable nullValue = NullWritable.get();
	//private static final int MISSING = 9999;

	@Override
    public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
        String datalist[] = value.toString().split(";");
        int vehicleid = Integer.parseInt(datalist[0]);
        Text driver = new Text("Driver="+datalist[1]);
        //String longitude = datalist[1], latitude = datalist[2];
        //long timemilli = Util.dateStr2IntMiSeconds(datalist[5]);
        //
        car.setVehicleid(vehicleid);
        //car.setDriver(driver);
        //
		context.write(car, driver);
        
    }
}
