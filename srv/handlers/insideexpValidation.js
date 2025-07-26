export function validateCandidateInsideExperience(data = [], req) {
    console.log("Outside Work Experience:");
    console.log(data);
  
    for (const exp of data) {
      if (!exp.startDate) {
        req.error(400, "Please provide the start date of employment.");
      }
  
      if (!exp.endDate && exp.isCurrent === false) {
        req.error(400, "Please provide the end date of employment.");
      }
  
      if (exp.isCurrent === true && exp.endDate) {
        req.error(400, "End date should be empty for a current position.");
      }
  
      if (exp.startDate && exp.endDate && new Date(exp.startDate) > new Date(exp.endDate)) {
        req.error(400, "Start date cannot be later than end date.");
      }
  
    
      if (exp.salary < 0) {
        req.error(400, "Salary must be a positive number.");
      }
  
      
  
     
  
     
    }
  }
  