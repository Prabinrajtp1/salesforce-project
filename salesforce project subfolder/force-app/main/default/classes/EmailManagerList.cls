public class EmailManagerList {

    public void sendemails(List<String> emails) {

        List<Messaging.SingleEmailMessage> emailList =
            new List<Messaging.SingleEmailMessage>();

        String subject = 'Testing';
        String body = 'Hey, this is a sample message';

        for (String email : emails) {

            Messaging.SingleEmailMessage mail =
                new Messaging.SingleEmailMessage();

            mail.setToAddresses(new List<String>{email});
            mail.setSubject(subject);
            mail.setPlainTextBody(body);

            emailList.add(mail);
        }

        if (!emailList.isEmpty()) {
            Messaging.sendEmail(emailList);
        }
    }
}