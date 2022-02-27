import org.apache.hadoop.io.WritableComparable;
import org.apache.hadoop.io.WritableComparator;



public class CarPairComparator extends WritableComparator {

	
	 public CarPairComparator() {
	        super(Car.class, true);
	    }
	 
	 @Override
	 public int compare(WritableComparable tp1, WritableComparable tp2) {
		Car pair1 = (Car) tp1;
		Car pair2 = (Car) tp2;
	   
		return pair1.compareTo(pair2);
	 }
}
