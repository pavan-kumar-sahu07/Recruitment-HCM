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



  function validateResumeIsPdf(req) {
    const resumeBuffer = req.data.resume;

    // if (!resumeBuffer) {
    //   req.error(400, 'Resume file is missing.');
    // }

      const isPDF = resumeBuffer[0] === 0x25 &&
                  resumeBuffer[1] === 0x50 &&
                  resumeBuffer[2] === 0x44 &&
                  resumeBuffer[3] === 0x46;

    if (!isPDF) {
      req.error(400, 'Uploaded file is not a valid PDF.');
    }
  }
};
