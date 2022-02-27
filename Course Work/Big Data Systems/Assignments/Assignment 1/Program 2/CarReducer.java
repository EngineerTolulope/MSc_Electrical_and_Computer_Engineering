import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

import java.io.IOException;


public class CarReducer extends Reducer<Car, Text, Text, Text> {
    @Override
    protected void reduce(Car key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
    	int count = 0;
        Text driver = null;
    	String val[];
        double v1=0, v2,acc;
        long Tp = 0, Tc, T;
        //
        for (Text value : values){
        	val = value.toString().split("=");
        	if(val[0].equals("Velocity")){
        		v2 = Double.parseDouble(val[1]);
        		Tc = key.getTime().get();
        		T = (Tc - Tp)/1000;
        		acc =((v2 - v1)/3.6)/T;
        		//
        		if (acc < -3.0 || acc > 3.0){
        			count++;
        		}
        	}else if (val[0].equals("Driver")){
        		driver = new Text (val[1]);
        	}
        	
        	
        }
        //
        if (count >= 5){
        	
        	context.write(driver, new Text(String.valueOf(count)));
        }
        
        
    }
}
