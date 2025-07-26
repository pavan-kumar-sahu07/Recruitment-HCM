import cds from '@sap/cds';

export async function generateCandidateNumber(Candidate, req) {
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
  return `CAND-${String(newNumber).padStart(3, '0')}`;
}
