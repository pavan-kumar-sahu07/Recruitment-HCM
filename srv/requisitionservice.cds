using { sap.hcm.recruiting } from '../db/recruitment';


service RequisitionService {
    entity JobRequisition as projection on recruiting.JobRequisition;
    
}