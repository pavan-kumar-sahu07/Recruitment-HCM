import { expect } from "chai";
import sinon from "sinon";
import {validateEducationData} from '../../srv/handlers/educationValidation.js';


describe("validateEducationData()",()=>{
    let req;
    beforeEach(()=>{
        req={
            error:sinon.spy()
        };
    });

    it("Should Reject if degree is null",()=>{
        const education=[{degree:null}];
        validateEducationData(education,req);
        expect(req.error.calledWith(400,"Please Enter Degree")).to.be.true;
    });

    it("Should reject if GPA is greater than Max GPA",()=>{
        const education=[{
                degree:"Btech",
                gpa:9.5,
                maxGpa:9.0
            }];
        validateEducationData(education,req);
        expect(req.error.calledWith(400, "GPA cannot be greater than Max GPA.")).to.be.true;


    });

  
})