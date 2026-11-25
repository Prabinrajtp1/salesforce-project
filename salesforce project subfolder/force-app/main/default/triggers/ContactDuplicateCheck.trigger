trigger ContactDuplicateCheck on Contact (before insert, before update) {

    Set<String> emailSet = new Set<String>();

    // Collect all email addresses
    for (Contact con : Trigger.new) {
        if (con.Email != null) {
            emailSet.add(con.Email.trim().toLowerCase());
        }
    }

    // Query existing contacts
    Map<String, Id> existingEmailMap = new Map<String, Id>();

    for (Contact con : [
        SELECT Id, Email
        FROM Contact
        WHERE Email != null
        AND Email IN :emailSet
    ]) {
        existingEmailMap.put(con.Email.toLowerCase(), con.Id);
    }

    // Check duplicates
    for (Contact con : Trigger.new) {

        if (con.Email != null) {

            String email = con.Email.trim().toLowerCase();

            if (existingEmailMap.containsKey(email) &&
                existingEmailMap.get(email) != con.Id) {

                con.Email.addError(
                    'A Contact with this Email already exists.'
                );
            }
        }
    }
}