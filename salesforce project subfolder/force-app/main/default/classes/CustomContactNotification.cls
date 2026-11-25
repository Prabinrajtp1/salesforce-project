public class CustomContactNotification {

    public static void sendNotification(Set<String> recipientIds) {

        // Get the Notification Type Id
        CustomNotificationType notificationType = [
            SELECT Id, DeveloperName
            FROM CustomNotificationType
            WHERE DeveloperName = 'sampleCustomNotification'
            LIMIT 1
        ];

        // Create the notification
        Messaging.CustomNotification notification =
            new Messaging.CustomNotification();

        // Set notification details
        notification.setTitle('Trailhead Trigger Tutorial');
        notification.setBody('Contact(s) were inserted.');
        notification.setNotificationTypeId(notificationType.Id);

        // Send notification to all recipients
        try {
            notification.send(recipientIds);

            System.debug('Custom notification sent successfully.');
        }
        catch (Exception e) {
            System.debug(
                'Problem sending notification: ' + e.getMessage()
            );
        }
    }
}