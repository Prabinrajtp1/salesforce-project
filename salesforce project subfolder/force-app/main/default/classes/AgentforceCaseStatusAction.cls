public with sharing class AgentforceCaseStatusAction {

    public class CaseRequest {
        @InvocableVariable(
            label='Case Number'
            description='Salesforce case number, e.g. 00001234 or 1234'
            required=true
        )
        public String caseNumber;
    }

    public class CaseResponse {
        @InvocableVariable(label='Case Number')
        public String caseNumber;

        @InvocableVariable(label='Case Subject')
        public String caseSubject;

        @InvocableVariable(label='Case Status')
        public String caseStatus;

        @InvocableVariable(label='Message')
        public String message;
    }

    @InvocableMethod(
        label='Get Case Details from Case Number'
        description='Retrieve case subject and status from a Case Number'
    )
    public static List<CaseResponse> getCaseDetail(List<CaseRequest> requests) {

        List<CaseResponse> responses = new List<CaseResponse>();

        Set<String> caseNumbers = new Set<String>();
        for (CaseRequest req : requests) {
            String n = normalize(req.caseNumber);
            if (String.isNotBlank(n)) {
                caseNumbers.add(n);
            }
        }

        Map<String, Case> caseMap = new Map<String, Case>();
        if (!caseNumbers.isEmpty()) {
            for (Case c : [
                SELECT Id, CaseNumber, Status, Subject
                FROM Case
                WHERE CaseNumber IN :caseNumbers
            ]) {
                caseMap.put(c.CaseNumber, c);
            }
        }

        for (CaseRequest req : requests) {
            CaseResponse res = new CaseResponse();
            String n = normalize(req.caseNumber);
            res.caseNumber = n;

            if (caseMap.containsKey(n)) {
                Case c = caseMap.get(n);
                res.caseSubject = c.Subject;
                res.caseStatus = c.Status;
                res.message = 'Case found successfully';
            } else {
                res.message = 'No case found for case number ' + n;
            }
            responses.add(res);
        }

        return responses;
    }

    // Removes "#", spaces and text, then pads to 8 digits (default Case Number format)
    private static String normalize(String input) {
        if (String.isBlank(input)) {
            return '';
        }
        String digits = input.replaceAll('[^0-9]', '');
        if (String.isBlank(digits)) {
            return input.trim();
        }
        return digits.leftPad(8, '0');
    }
}