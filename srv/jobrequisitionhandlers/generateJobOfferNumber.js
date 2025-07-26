import cds from '@sap/cds';

export const generateJobOfferNumber = async (jobOfferData, req) => {
    console.log("DATA IN JOB OFFER",jobOfferData )
  const db = cds.transaction(req);
  const { JobOffer } = cds.entities;

  try {
    const latest = await db.run(
      SELECT.one.from(JobOffer)
        .columns('offerNumber')
        .orderBy({ offerNumber: 'desc' })
    );

    let max = 0;
    if (latest?.offerNumber) {
      const parts = latest.offerNumber.split('-');
      max = parseInt(parts[1], 10) || 0;
    }

    if (!jobOfferData.offerNumber) {
      const newNumber = max + 1;
      jobOfferData.offerNumber = `OFF-${String(newNumber).padStart(3, '0')}`;
    }

  } catch (e) {
    console.error('Error generating offer number:', e);
    req.error(500, 'Failed to generate offer number.');
  }
};
