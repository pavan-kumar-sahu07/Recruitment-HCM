using { sap.hcm.recruiting } from '../db/recruitment';

service CandidateService {

    @odata.draft.enabled
    entity Candidate as projection on recruiting.Candidate;

}
