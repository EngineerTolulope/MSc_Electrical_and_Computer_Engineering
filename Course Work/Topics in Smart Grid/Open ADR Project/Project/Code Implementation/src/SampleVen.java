
import com.siemens.dg.drakkaven.VenEventChange;
import com.siemens.dg.drakkaven.oadr.DurationPropType;
import com.siemens.dg.drakkaven.oadr.EiTargetType;
import com.siemens.dg.drakkaven.oadr.Intervals;
import com.siemens.dg.drakkaven.oadr.OadrReportDescriptionType;
import com.siemens.dg.drakkaven.oadr.OadrReportRequestType;
import com.siemens.dg.drakkaven.oadr.OadrReportType;
import com.siemens.dg.drakkaven.oadr.OadrSamplingRateType;
import com.siemens.dg.drakkaven.ven.species.java.EventResult;
import java.time.Duration;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.xml.datatype.DatatypeConfigurationException;

public class SampleVen implements Ven {

    private static final Logger logger = LoggerFactory.getLogger(SampleVen.class);

    private static final DatatypeFactory factory;
    private static final String NAME_METADATA_STATUS_REPORT = "METADATA_TELEMETRY_STATUS";
    private static final String NAME_STATUS_REPORT = "TELEMETRY_STATUS";

    static {
        try {
            factory = DatatypeFactory.newInstance();
        } catch (DatatypeConfigurationException e) {
            throw new RuntimeException(e);
        }
    }

    private final Map<String, OadrReportType> registeredReports = new HashMap();
    private final Map<String, OadrReportRequestType> createdReports = new HashMap();

    private static DurationPropType toXmlDurationMinutes(Duration duration) {
        DurationPropType durationPropType = new DurationPropType();
        durationPropType.setDuration("PT" + duration.toMinutes() + "M");
        return durationPropType;
    }

    public List<EventResult> onVenEventChanges(List<VenEventChange> venEventChanges) {
        logger.info("*********** SAMPLE ADAPTER - EVENT CHANGE ***************.");
        logger.info("Received {} events to process", Integer.valueOf(venEventChanges.size()));
        return (List) venEventChanges.stream()
                .map(event -> new EventResult(event.getEvent(), true))
                .collect(Collectors.toList());
    }

    public List<OadrReportType> registerReports() {
        logger.info("*********** SAMPLE ADAPTER - REGISTER REPORTS ***************.");
        logger.info("Asked to register reports; returning no reports.");

        OadrReportType report = new OadrReportType();
        report.setCreatedDateTime(now());

        report.setReportName("METADATA_TELEMETRY_STATUS");

        report.setDuration(toXmlDurationMinutes(Duration.ofHours(2L)));

        report.setReportSpecifierID("SAMP-" + UUID.randomUUID().toString());

        report.setReportRequestID("0");

        OadrReportDescriptionType reportDescriptionType = new OadrReportDescriptionType();

        reportDescriptionType.setRID("status");

        EiTargetType target = new EiTargetType();

        reportDescriptionType.setReportSubject(target);

        reportDescriptionType.setReportType("x-resourceStatus");
        reportDescriptionType.setReadingType("x-notApplicable");

        OadrSamplingRateType sampleRate = new OadrSamplingRateType();
        sampleRate.setOadrMinPeriod(toXmlDurationMinutes(Duration.ofMinutes(5L)).getDuration());
        sampleRate.setOadrMaxPeriod(toXmlDurationMinutes(Duration.ofMinutes(5L)).getDuration());

        sampleRate.setOadrOnChange(false);
        reportDescriptionType.setOadrSamplingRate(sampleRate);
        report.getOadrReportDescription().add(reportDescriptionType);

        this.registeredReports.put(report.getReportSpecifierID(), report);
        return Collections.singletonList(report);
    }

    public Set<String> createReport(List<OadrReportRequestType> reportRequests) {
        return Collections.emptySet();
    }

    public List<OadrReportType> getReports() {
        logger.info("getReports method called, examining reports for new data");

        return (List) this.createdReports.entrySet().stream()
                .map(entry -> {
                    OadrReportType report = new OadrReportType();
                    report.setReportRequestID((String) entry.getKey());

                    OadrReportRequestType reportRequest = (OadrReportRequestType) entry.getValue();
                    report.setIntervals(retrieveIntervals((String) entry.getKey(), reportRequest));

                    report.setDuration(reportRequest.getReportSpecifier().getReportBackDuration());
                    report.setReportRequestID(reportRequest.getReportRequestID());
                    report.setReportSpecifierID(reportRequest.getReportSpecifier().getReportSpecifierID());
                    report.setCreatedDateTime(now());
                    return report;

                }).filter(report -> !report.getIntervals().getInterval().isEmpty())
                .collect(Collectors.toList());
    }

    private Intervals retrieveIntervals(String reportRequestId, OadrReportRequestType reportRequest) {
        return new Intervals();
    }

    private XMLGregorianCalendar now() {
        return factory.newXMLGregorianCalendar(new GregorianCalendar());
    }
}
