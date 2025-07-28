import cds from '@sap/cds';
import { validateCandidateData } from './handlers/candidateValidation.js';
import { validateEducationData } from './handlers/educationValidation.js';
import { generateCandidateNumber } from './handlers/candidateNumberGenerator.js';
import { validateCandidateOutsideExperience } from './handlers/outsideworkexprienceValidation.js';
import { validateCandidateInsideExperience } from './handlers/insideexpValidation.js'
export default (srv) => {
  const { Candidate } = srv.entities;

  srv.before("CREATE", Candidate, async (req) => {
    const c = req.data;

    
    req.data.candidateNumber = await generateCandidateNumber(Candidate, req);
    validateCandidateData(c, req);
    // validateResumeIsPdf(req);
    validateEducationData(c.education, req);
    validateCandidateOutsideExperience(c.workExperienceOutside,req);
    validateCandidateInsideExperience(c.workExperienceInside,req);

  });

  srv.before("UPDATE", Candidate, async (req) => {
    const c = req.data;

    validateCandidateData(c, req);
    // validateResumeIsPdf(req);
    validateEducationData(c.education, req);
    validateCandidateOutsideExperience(c.workExperienceOutside,req);
    validateCandidateInsideExperience(c.workExperienceInside,req);
  });

};
