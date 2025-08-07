import { expect } from "chai";
import sinon from 'sinon';

import {validateCandidateInsideExperience} from '../../srv/handlers/insideexpValidation.js';


describe('validateCandidateInsideExperience()',()=>{
        let req;

        beforeEach(()=>{
            req={
                error:sinon.spy()
            }
        });

        
        it("should be rejected if start date is null",()=>{
                const exp=[{
                    startDate:null
                }];
            validateCandidateInsideExperience(exp,req);
            expect(req.error.calledWith(400,"Please provide the start date of employment.")).to.be.true;
        });

        it("should be rejected if end date is null",()=>{
            const exp=[{
                endDate:null,
                isCurrent:false
            }]
            validateCandidateInsideExperience(exp,req);
            expect(req.error.calledWith(400,"Please provide the end date of employment.")).to.be.true;
        })

        
});
