import {validateJobRequisitionData} from './jobrequisitionhandlers/jobrequistionDataValidation.js';
import { validateJobApplicationData } from './jobrequisitionhandlers/jobapplicationValidations.js';
import {generateJobApplicationNumber} from './jobrequisitionhandlers/generateJobApplicationNumber.js';
import {generateIntervireNumber} from './jobrequisitionhandlers/generateJobinterviewsNumber.js';
import  triggerBpa  from './externalApis/bpatrigger.js'
import {generateJobOfferNumber} from './jobrequisitionhandlers/generateJobOfferNumber.js'
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


    //Job Application
    for(jobapplication of jobRequisitionData.applications){
      validateJobApplicationData(jobapplication,req);
      generateJobApplicationNumber(jobapplication,req);
    }
    //Job Offers
    for(let application of jobRequisitionData.applications){
      
        for(let offersData of application.offers){
          generateJobOfferNumber(offersData,req);
      }
    }




  });

  srv.before('UPDATE',JobRequisition,(req)=>{
    const jobRequisitionData = req.data;

    console.log("update data")
    console.log(jobRequisitionData);

    validateJobRequisitionData(jobRequisitionData,req);

    //bpa apis
    triggerBpa(jobRequisitionData);


    // job Application Validations 
    for(let jobapplication of jobRequisitionData.applications){
       validateJobApplicationData(jobapplication,req);
       generateJobApplicationNumber(jobapplication,req);
      }

      //job interview Validation

      for(let application of jobRequisitionData.applications){
          if(application.interviews){
            for(let interview of application.interviews){
             generateIntervireNumber(interview,req);
            }
          }
      }

      //JOB OFFER VALIDATIONS

      for(let application of jobRequisitionData.applications){
        if(application.offers){
          for(let offersData of application.offers){
           generateIntervireNumber(offersData,req);
          }
        }
      }
  
  });
};
