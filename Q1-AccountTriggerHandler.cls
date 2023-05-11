public class AccountTriggerHandler {
    public static void beforeInsertUpdate(List<Account> accounts, Map<Id, Account> mapOldAcc) {
        for (Account acc : accounts) {
            if (acc.BillingPostalCode != null) {
                String normalizedPostalCode = normalizePostalCode(acc.BillingPostalCode);
                if (normalizedPostalCode == null) {
                    acc.addError('CEP inválido. Informe no formato "XXXXX-XXX" ou apenas números.');
                } else {
                    acc.BillingPostalCode = normalizedPostalCode;
                }
            }
        }
    }

    private static String normalizePostalCode(String postalCode) {
        postalCode = postalCode.replaceAll('[^0-9]', '');
        
        if (postalCode.length() == 8) {
            return postalCode.substring(0, 5) + '-' + postalCode.substring(5, 8);
        } else if (postalCode.length() == 9 && postalCode.substring(5, 6) == '-') {
            return postalCode;
        } else {
            return null;
        }
    }
}