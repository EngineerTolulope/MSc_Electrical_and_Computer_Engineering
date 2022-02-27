/*import org.apache.hadoop.io.Text;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;*/

import org.apache.hadoop.io.Text;
//import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
//import org.apache.hadoop.mapreduce.lib.input.MultipleInputs;
//import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
//import org.apache.hadoop.mapreduce.lib.output.MultipleOutputs;
//import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;



public class CarDriver {

    public static void main(String[] args) throws Exception {

        if(args.length < 2){
            System.out.println("Please supply in input and output path");
            System.exit(1);
        }

        Job job = Job.getInstance(new Configuration());
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        job.setJarByClass(CarDriver.class);
        
        job.setOutputKeyClass(Car.class);
		//job.setOutputValueClass(IntWritable.class);
        job.setOutputValueClass(Text.class);
		
		job.setMapperClass(CarMapper.class);
		job.setPartitionerClass(CarPartitioner.class);
		job.setSortComparatorClass(CarPairComparator.class);
		job.setGroupingComparatorClass(CarGroupingComparator.class);
		job.setReducerClass(CarReducer.class);
        
        
        System.exit(job.waitForCompletion(true) ? 0 : 1);

    }
}
