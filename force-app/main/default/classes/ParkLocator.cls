public class ParkLocator {
	public static String[] country(String c) {
        ParkService.ParksImplPort park = 
            new ParkService.ParksImplPort();
        return park.byCountry('Germany');
    }
}