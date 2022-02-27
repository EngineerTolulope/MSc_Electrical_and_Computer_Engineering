import org.apache.hadoop.io.Text;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.MultipleInputs;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.MultipleOutputs;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;



public class CarDriver {
	public int run(String[] args) throws Exception{
		if(args.length < 3){
            System.out.println("Please supply in input and output path");
            System.exit(1);
        }
		//
		Job job = new Job();
		//
		job.setJarByClass(CarDriver.class);
		job.setJobName("Finding Dangerous Drivers");
		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[2]));
		//
		MultipleInputs.addInputPath(job, new Path(args[0]), TextInputFormat.class, CarMapper.class);
        MultipleInputs.addInputPath(job, new Path(args[1]), TextInputFormat.class, DriverMapper.class);
        //
        job.setPartitionerClass(CarPartitioner.class);
		job.setSortComparatorClass(CarPairComparator.class);
		job.setGroupingComparatorClass(CarGroupingComparator.class);
		job.setReducerClass(CarReducer.class);
		//
		job.setOutputKeyClass(Car.class);
		job.setOutputValueClass(Text.class);
		//
		System.exit(job.waitForCompletion(true) ? 0:1);
		return job.waitForCompletion(true) ? 0 : 1; 
	}
	//
	public static void main(String[] args) throws Exception {
		CarDriver driver = new CarDriver();
		driver.run(args);
	}
    /*public static void main(String[] args) throws Exception {

        if(args.length < 3){
            System.out.println("Please supply in input and output path");
            System.exit(1);
        }

        Job job = Job.getInstance(new Configuration());
        FileOutputFormat.setOutputPath(job, new Path(args[2]));
        
        MultipleInputs.addInputPath(job, new Path(args[0]), TextInputFormat.class, CarMapper.class);
        MultipleInputs.addInputPath(job, new Path(args[1]), TextInputFormat.class, DriverMapper.class);
        MultipleOutputs.addNamedOutput(job, "DriversName", TextOutputFormat.class, Car.class, Text.class);
        //
        job.setJarByClass(CarDriver.class);
        //
        job.setOutputKeyClass(Car.class);
		//job.setOutputValueClass(IntWritable.class);
        //job.setOutputValueClass(Text.class);
		//
		job.setPartitionerClass(CarPartitioner.class);
		job.setSortComparatorClass(CarPairComparator.class);
		job.setGroupingComparatorClass(CarGroupingComparator.class);
		job.setReducerClass(CarReducer.class);
        //
        System.exit(job.waitForCompletion(true) ? 0 : 1);

    }*/
}
