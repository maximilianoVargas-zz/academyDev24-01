public class ParkLocator {
    public static List<String> country(String country){
        ParkService.ParksImplPort parkService = 
            new ParkService.ParksImplPort();
        return parkService.byCountry(country);
    }
}