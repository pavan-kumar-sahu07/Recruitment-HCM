import cds from '@sap/cds';

export default (srv) => {
  const { Candidate } = srv.entities;

  srv.before('CREATE', Candidate, async (req) => {
    const db = cds.transaction(req);

    const result = await db.run(
      SELECT.one.from(Candidate)
        .columns('candidateNumber')
        .orderBy({ candidateNumber: 'desc' })
    );

    let max = 0;
    if (result?.candidateNumber) {
      const parts = result.candidateNumber.split('-');
      max = parseInt(parts[1]) || 0;
    }

    const newNumber = max + 1;
    req.data.candidateNumber = `CAND-${newNumber}`;
  });
};
