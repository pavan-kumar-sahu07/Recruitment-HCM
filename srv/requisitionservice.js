import cds from '@sap/cds';

export default (srv) => {
  const { JobRequisition } = srv.entities;

  srv.before('CREATE', JobRequisition, async (req) => {
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
    req.data.requisitionNumber = `REQ-${newNumber}`;
  });
};
