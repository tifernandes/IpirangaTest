//O problema com o código apresentado é que ele está realizando uma consulta ao banco de dados dentro de um loop "for". 
//Isso pode resultar em uma queda de desempenho significativa quando o tamanho da lista "Opp" é grande, pois uma consulta é executada para cada iteração do loop.
//Segue abaixo o código corrigido

public class BloqueiaIntegracao {
    public static void BloqueiaIntegracao(List<Opportunity> Opp) {
        Set<Id> opportunityIds = new Set<Id>();
        for (Opportunity oppA : Opp) {
            opportunityIds.add(oppA.Id);
        }
        
        List<OpportunityContactRole> oppContacts = [
            SELECT Id
            FROM OpportunityContactRole
            WHERE OpportunityId IN :opportunityIds
            AND Role = 'Responsável Financeiro'
        ];

        Set<Id> oppsWithFinanceContact = new Set<Id>();
        for (OpportunityContactRole oppContact : oppContacts) {
            oppsWithFinanceContact.add(oppContact.OpportunityId);
        }
        
        for (Opportunity oppA : Opp) {
            if (!oppsWithFinanceContact.contains(oppA.Id)) {
                oppA.addError('É necessário ter o papel financeiro alinhado na oportunidade.');
            }
        }
    }
}