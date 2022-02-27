import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.mapreduce.Partitioner;


public class CarPartitioner extends Partitioner<Car, NullWritable> {

    @Override
    public int getPartition(Car car, NullWritable nullWritable, int numPartitions) {
        return car.getVehicleid().hashCode() % numPartitions;
    }
}
