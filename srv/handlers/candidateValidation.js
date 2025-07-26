export function validateCandidateData(c, req) {

  const phoneRegex = /^[0-9]{10}$/;


  if (!c.phone || !phoneRegex.test(c.phone)) {
    req.error(400, "Enter a valid phone number (10 digits)");
  }
  
  if(!c.alternatePhone || !phoneRegex.test(c.alternatePhone)){
    req.error(400, "Enter a valid Alternative phone number (10 digits)");
  }
  if (c.expectedSalary != null && c.currentSalary != null && c.expectedSalary <= c.currentSalary) {
    req.error(400, "Expected salary must be greater than current salary.");
  }

  if (c.phone && c.alternatePhone && c.phone === c.alternatePhone) {
    req.error(400, "Alternate phone number must be different from the primary phone number.");
  }

  if (c.availabilityDate && new Date(c.availabilityDate) < new Date().setHours(0, 0, 0, 0)) {
    req.error(400, "Availability date cannot be in the past.");
  }

  if (c.email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(c.email)) {
    req.error(400, "Please enter a valid email address.");
  }
}
