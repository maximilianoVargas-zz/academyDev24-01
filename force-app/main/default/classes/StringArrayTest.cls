public class StringArrayTest {
    public static List<String> generateStringArray(Integer n){
		List<String> tests = new List<String>();
        String test = '';
        for(integer i = 0; i < n; i++){
            tests.add('Test ' + i);
        }
		return tests;        
    }
}