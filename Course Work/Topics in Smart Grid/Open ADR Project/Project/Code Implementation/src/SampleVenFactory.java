
import com.siemens.dg.drakkaven.Ven;
import com.siemens.dg.drakkaven.VenFactory;
import com.siemens.dg.drakkaven.VenFactoryConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SampleVenFactory
        implements VenFactory {

    private static final Logger logger = LoggerFactory.getLogger(SampleVenFactory.class);

    public Ven build(VenFactoryConfig config) {
        logger.info("Constructing Sample VEN using configuration {}", config);

        return new SampleVen();
    }
}
