import { expect } from "chai";
import sinon from "sinon";
import { validateCandidateData } from "../../srv/handlers/candidateValidation.js";

describe('validateCandidateData()', () => {
  let req;

  beforeEach(() => {
    req = {
      error: sinon.spy()
    };
  });

  it('should reject invalid phone number', () => {
    validateCandidateData({ phone: '123' }, req);
    expect(req.error.calledWith(400, "Enter a valid phone number (10 digits)")).to.be.true;
  });

  it('should reject invalid alternate phone number', () => {
    validateCandidateData({ phone: '1234567890', alternatePhone: 'abc' }, req);
    expect(req.error.calledWith(400, "Enter a valid Alternative phone number (10 digits)")).to.be.true;
  });

  it('should reject if expected salary is not greater than current salary', () => {
    validateCandidateData({ phone: '1234567890', alternatePhone: '0987654321', currentSalary: 5000, expectedSalary: 4000 }, req);
    expect(req.error.calledWith(400, "Expected salary must be greater than current salary.")).to.be.true;
  });

  it('should reject if phone and alternate phone are the same', () => {
    validateCandidateData({ phone: '1234567890', alternatePhone: '1234567890' }, req);
    expect(req.error.calledWith(400, "Alternate phone number must be different from the primary phone number.")).to.be.true;
  });

  it('should reject if availability date is in the past', () => {
    const yesterday = new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString().split('T')[0];
    validateCandidateData({ phone: '1234567890', alternatePhone: '0987654321', availabilityDate: yesterday }, req);
    expect(req.error.calledWith(400, "Availability date cannot be in the past.")).to.be.true;
  });

  it('should reject invalid email address', () => {
    validateCandidateData({ phone: '1234567890', alternatePhone: '0987654321', email: 'invalidemail' }, req);
    expect(req.error.calledWith(400, "Please enter a valid email address.")).to.be.true;
  });

  it('should not reject valid data', () => {
    const tomorrow = new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString().split('T')[0];
    const candidate = {
      phone: '1234567890',
      alternatePhone: '0987654321',
      currentSalary: 4000,
      expectedSalary: 5000,
      availabilityDate: tomorrow,
      email: 'valid@example.com'
    };

    validateCandidateData(candidate, req);
    expect(req.error.called).to.be.false;
  });
});
