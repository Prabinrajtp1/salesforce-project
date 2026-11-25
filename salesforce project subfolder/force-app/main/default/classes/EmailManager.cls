public class EmailManager {
     //this is for single email 
    public void sendemail(String toaddress,String subject,String body)
    {
       //Create email object
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String [] toaddresses = new String[] {toaddress};
       //map Ourinputs into mail variable
        mail.setToAddresses(toaddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        // Pass this email message to the built-in sendEmail method
        // of the Messaging class
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
         
        
    }
    
     





}