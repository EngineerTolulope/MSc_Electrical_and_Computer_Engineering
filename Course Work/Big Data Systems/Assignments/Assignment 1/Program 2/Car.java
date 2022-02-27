import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.Writable;
import org.apache.hadoop.io.WritableComparable;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;

public class Car implements Writable, WritableComparable<Car> {
	private IntWritable vehicleid = new IntWritable();
	private LongWritable time = new LongWritable();
	private Text driver = new Text();

    public Car() {
    }

    public Car(IntWritable vehicleid, LongWritable time) {
        super();
        this.vehicleid = vehicleid;
        this.time = time;
    }
    

    public Text getDriver() {
		return driver;
	}

	public void setDriver(Text driver) {
		this.driver = driver;
	}
	
	public IntWritable getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(int vehicleid) {
		this.vehicleid.set(vehicleid);;
	}

	public LongWritable getTime() {
		return time;
	}

	public void setTime(long time) {
		this.time.set(time);;
	}

	public void write(DataOutput output) throws IOException {
		time.write(output);
		vehicleid.write(output);
	}
	public int compareTo(Car pair) {
        int compareValue = this.vehicleid.compareTo(pair.getVehicleid());
        if (compareValue == 0) compareValue = this.time.compareTo(pair.getTime());
        return compareValue;
    }
	
	@Override
    public int hashCode() {
		final int n = 31;
		int result =1;
		result = n * result + ((vehicleid == null) ? 0 : vehicleid.hashCode());
		result = n * result + ((time == null) ? 0 : time.hashCode());
        return result;
    }
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Car other = (Car) obj;
		if (vehicleid == null) {
			if (other.vehicleid != null)
				return false;
		} else if (!vehicleid.equals(other.vehicleid))
			return false;
		if (time == null) {
			if (other.time != null)
				return false;
		} else if (!time.equals(other.time))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "VehicleID = "+ vehicleid + "Time = " + time + "Driver = " + driver;
	}
	
	@Override
    public void readFields(DataInput in) throws IOException {
        time.readFields(in);
        vehicleid.readFields(in);
    }
}
