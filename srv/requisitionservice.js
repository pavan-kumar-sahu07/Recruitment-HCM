import {validateJobRequisitionData} from './jobrequisitionhandlers/jobrequistionDataValidation.js';
import { validateJobApplicationData } from './jobrequisitionhandlers/jobapplicationValidations.js';
import {generateJobApplicationNumber} from './jobrequisitionhandlers/generateJobApplicationNumber.js';
import  triggerBpa  from './externalApis/bpatrigger.js'
import cds from '@sap/cds';


export default (srv) => {
  const { JobRequisition } = srv.entities;

  srv.before('CREATE', JobRequisition, async (req) => {
    const jobRequisitionData = req.data;
    console.log("Job Requisition Data:");
    console.log(jobRequisitionData);

    const db = cds.transaction(req);
    const result = await db.run(
      SELECT.one.from(JobRequisition)
        .columns('requisitionNumber')
        .orderBy({ requisitionNumber: 'desc' })
    );
    let max = 0;
    if (result?.requisitionNumber) {
      const parts = result.requisitionNumber.split('-');
      max = parseInt(parts[1], 10) || 0;
    }
    const newNumber = max + 1;
    req.data.requisitionNumber = `REQ-${String(newNumber).padStart(3, '0')}`;
    validateJobRequisitionData(jobRequisitionData, req);

    //Sending Data To BPA
    triggerBpa(jobRequisitionData);
    // job Application Validation 

    generateJobApplicationNumber(jobRequisitionData.applications,req);




  });

  srv.before('UPDATE',JobRequisition,(req)=>{
    const jobRequisitionData = req.data;

    console.log("update data")
    console.log(jobRequisitionData);

    validateJobRequisitionData(jobRequisitionData,req);

    // job Application Validations 

    validateJobApplicationData(jobRequisitionData.applications,req);
    generateJobApplicationNumber(jobRequisitionData.applications,req);
  });
};
