public with sharing class CaseDetailsAction {

    @InvocableMethod(
        label='Get Case Details'
        description='Returns key details for a Case given its Case Number.'
    )
    public static List<CaseDetailsResult> getCaseDetails(List<CaseInput> requests) {
        List<CaseDetailsResult> results = new List<CaseDetailsResult>();

        for (CaseInput req : requests) {
            CaseDetailsResult result = new CaseDetailsResult();

            Case c = [
                SELECT CaseNumber, Subject, Status, Priority, Description
                FROM Case
                WHERE CaseNumber = :req.caseNumber
                LIMIT 1
            ];

            if (c != null) {
                result.caseNumber = c.CaseNumber;
                result.subject = c.Subject;
                result.status = c.Status;
                result.priority = c.Priority;
                result.description = c.Description;
            }

            results.add(result);
        }

        return results;
    }

    // Request wrapper - field name "caseNumber" must match the
    // valuechange event payload key dispatched by caseInputEditor.js
    public class CaseInput {
        @InvocableVariable(label='Case Number' required=true)
        public String caseNumber;
    }

    // Response wrapper - field names here must match the getters
    // used in caseDetailsRenderer.js
    public class CaseDetailsResult {
        @InvocableVariable(label='Case Number')
        public String caseNumber;

        @InvocableVariable(label='Subject')
        public String subject;

        @InvocableVariable(label='Status')
        public String status;

        @InvocableVariable(label='Priority')
        public String priority;

        @InvocableVariable(label='Description')
        public String description;
    }
}