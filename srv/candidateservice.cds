using { sap.hcm.recruiting } from '../db/recruitment';

service CandidateService {

    @odata.draft.enabled
    entity Candidate as projection on recruiting.Candidate;
    entity CandidateEducation as projection on recruiting.CandidateEducation;

    entity CandidateStatusOptions as projection on recruiting.CandidateStatusOptions;
    entity CandidateSourceOptions as projection on recruiting.CandidateSourceOptions;
    entity ProficiencyLevelOptions as projection on recruiting.ProficiencyLevelOptions;

}
