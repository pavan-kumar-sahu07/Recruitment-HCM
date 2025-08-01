import cds from '@sap/cds';

export const generateJobApplicationNumber = async (jobapplicationData, req) => {
  console.log("Job Application Data", jobapplicationData);

  const db = cds.transaction(req);
  const { JobApplication } = cds.entities;

  try {
    const latest = await db.run(
      SELECT.one.from(JobApplication)
        .columns('applicationNumber')
        .orderBy({ applicationNumber: 'desc' })
    );

    let max = 0;

    if (latest?.applicationNumber) {
      const parts = latest.applicationNumber.split('-');
      max = parseInt(parts[1], 10) || 0;
    }

    
      if(!jobapplicationData.applicationNumber) {
      const newNumber = max + 1;
      jobapplicationData.applicationNumber = `APP-${String(newNumber).padStart(3, '0')}`;
      }
    

    console.log("jobapplicationData.applicationNumber",jobapplicationData.applicationNumber)
    

  } catch (err) {
    console.error("Error generating application number:", err);
    req.error(500, "Could not generate application number.");
  }
};
