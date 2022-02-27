import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

import java.io.IOException;


public class CarReducer extends Reducer<Car, Text, Text, IntWritable> {
	
    @Override
    protected void reduce(Car key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
        
        int x1=0,y1=0,x2=0,y2=0;
        int distance= 0;
        String val[];
        //
       //longitude + "," + latitude; 
        for (Text value : values){
        	val = value.toString().split(",");
        	x2 = Integer.parseInt(val[0]);
        	y2 = Integer.parseInt(val[1]);
        	
        	distance = (int) (distance + Math.hypot(x2-x1, y2-y1));
        	
        	x1=x2;
        	y1=y2;
        }
        //
        distance*=500;
        //
		Text carid= new Text(key.getVehicleid() + ""); 
        context.write(carid, new IntWritable( distance));
        
        
    }
}
