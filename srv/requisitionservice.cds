using { sap.hcm.recruiting } from '../db/recruitment';


service RequisitionService {
    entity JobRequisition as projection on recruiting.JobRequisition;
    entity JobEmploymentTypeOptions as projection on recruiting.JobEmploymentTypeOptions;
    entity JobExperienceLevel as projection on recruiting.JobExperienceLevel;
    entity JobUrgencyLevel as projection on recruiting.JobUrgencyLevel;
    entity JobStatusOptions as projection on recruiting.JobStatusOptions;
    entity JobApplication as projection on recruiting.JobApplication;
    //   entity JobApplication as projection on recruiting.JobApplication;
    entity ApplicationStatusOptions as projection on recruiting.ApplicationStatusOptions;
    entity CandidateSourceOptions as projection on recruiting.CandidateSourceOptions;

}