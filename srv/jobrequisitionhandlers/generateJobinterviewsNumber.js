import cds from '@sap/cds';

export const generateIntervireNumber = async (jobinterviewdata, req) => {
  console.log("JOB INTERVIEW DATA:", jobinterviewdata);

  const db = cds.transaction(req);
  const { JobApplicationInterview } = cds.entities;

  try {
    const latest = await db.run(
      SELECT.one.from(JobApplicationInterview)
        .columns('jobInterviewNumber') 
        .orderBy({ jobInterviewNumber: 'desc' })
    );

    let max = 0;
    if (latest?.jobInterviewNumber) {
      const parts = latest.jobInterviewNumber.split('-');
      max = parseInt(parts[1], 10) || 0;
    }

    
    if (!jobinterviewdata.jobInterviewNumber) {
      const newNumber = max + 1;
      jobinterviewdata.jobInterviewNumber = `INT-${String(newNumber).padStart(3, '0')}`;
    }

  } catch (e) {
    console.error("Error while generating interview number:", e);
    req.error(500, "Failed to generate interview number");
  }
};
