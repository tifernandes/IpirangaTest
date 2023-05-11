@IsTest
private class AccountTriggerTest {
    @IsTest
    static void testValidPostalCodeFormat() {
        Account account = new Account(Name = 'Test Account', BillingPostalCode = '12345-678');
        insert account;

        Account updatedAccount = [SELECT BillingPostalCode FROM Account WHERE Id = :account.Id];
        System.assertEquals('12345-678', updatedAccount.BillingPostalCode);
    }

    @IsTest
    static void testNumericPostalCodeFormat() {
        Account account = new Account(Name = 'Test Account', BillingPostalCode = '12345678');
        insert account;

        Account updatedAccount = [SELECT BillingPostalCode FROM Account WHERE Id = :account.Id];
        System.assertEquals('12345-678', updatedAccount.BillingPostalCode);
    }

    @IsTest
    static void testInvalidPostalCodeFormat() {
        Account account = new Account(Name = 'Test Account', BillingPostalCode = 'ABC123');
        try {
            insert account;
            System.assert(false, 'A inserção deveria ter falhado devido ao formato inválido do CEP.');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('CEP inválido'));
        }
    }
}