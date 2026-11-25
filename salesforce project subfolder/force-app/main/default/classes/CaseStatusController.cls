public with sharing class CaseStatusController {

    @InvocableMethod(
        label='Get Case Status'
        description='Returns the status of a case when the customer gives a case number')
    public static List<String> getStatus(List<String> caseNumbers) {

        // 1. Query ONCE, using IN with the whole list
        Map<String, String> statusByNumber = new Map<String, String>();
        for (Case c : [SELECT CaseNumber, Status
                       FROM Case
                       WHERE CaseNumber IN :caseNumbers
                       WITH USER_MODE]) {
            statusByNumber.put(c.CaseNumber, c.Status);
        }

        // 2. Loop over the inputs and read from the Map (no query here)
        List<String> results = new List<String>();
        for (String num : caseNumbers) {
            if (statusByNumber.containsKey(num)) {
                results.add('Your case status is: ' + statusByNumber.get(num));
            } else {
                results.add('No case found with that number.');
            }
        }
        return results;
    }
}