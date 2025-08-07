import cds from '@sap/cds';
import { validateJobRequisitionData } from './jobrequisitionhandlers/jobrequistionDataValidation.js';
import { validateJobApplicationData } from './jobrequisitionhandlers/jobapplicationValidations.js';
import { generateJobApplicationNumber } from './jobrequisitionhandlers/generateJobApplicationNumber.js';
import { generateIntervireNumber } from './jobrequisitionhandlers/generateJobinterviewsNumber.js';
import { generateJobOfferNumber } from './jobrequisitionhandlers/generateJobOfferNumber.js';
import triggerBpa from './externalApis/bpatrigger.js';

export default (srv) => {
  const { JobRequisition } = srv.entities;

  // CREATE handler
  srv.before('CREATE', JobRequisition, async (req) => {
    const jobRequisitionData = req.data;
    console.log("Job Requisition Create Data:", jobRequisitionData);

    // Generate requisition number
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

    // Validation
    validateJobRequisitionData(jobRequisitionData, req);

    // Trigger BPA
    triggerBpa(jobRequisitionData);

    // Job Applications
    for (let jobapplication of jobRequisitionData.applications ?? []) {
      validateJobApplicationData(jobapplication, req);
      generateJobApplicationNumber(jobapplication, req);

      // Job Offers
      for (let offersData of jobapplication.offers ?? []) {
        generateJobOfferNumber(offersData, req);
      }
    }
  });


  srv.before('UPDATE', JobRequisition, (req) => {
    const jobRequisitionData = req.data;
    console.log("Job Requisition Update Data:", jobRequisitionData);

    // Validation
    validateJobRequisitionData(jobRequisitionData, req);

    // Trigger BPA
    triggerBpa(jobRequisitionData);

    // Job Applications
    for (let jobapplication of jobRequisitionData.applications ?? []) {
      validateJobApplicationData(jobapplication, req);
      generateJobApplicationNumber(jobapplication, req);

      // Job Interviews
      for (let interview of jobapplication.interviews ?? []) {
        generateIntervireNumber(interview, req);
      }

      // Job Offers
      for (let offersData of jobapplication.offers ?? []) {
        generateJobOfferNumber(offersData, req); 
      }
    }
  });
};
