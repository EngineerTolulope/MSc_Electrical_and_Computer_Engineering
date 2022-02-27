import org.apache.hadoop.io.WritableComparable;
import org.apache.hadoop.io.WritableComparator;


public class CarGroupingComparator extends WritableComparator {


    public CarGroupingComparator() {
        super(Car.class, true);
    }


    @Override
    public int compare(WritableComparable tp1, WritableComparable tp2) {
        Car car = (Car) tp1;
        Car car2 = (Car) tp2;
        return car.getVehicleid().compareTo(car2.getVehicleid());
    }
}
