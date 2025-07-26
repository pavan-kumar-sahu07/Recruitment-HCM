export function validateEducationData(education, req) {
    if (education?.length) {
      for (const edu of education) {
        
        if (edu.degree == null) {
          req.error(400, "Please Enter Degree");
        }
  
        if (edu.startDate && edu.endDate && new Date(edu.startDate) > new Date(edu.endDate)) {
          req.error(400, "Start Date must be before End Date in education.");
        }
  
        if (edu.gpa && edu.maxGpa && edu.gpa > edu.maxGpa) {
          req.error(400, "GPA cannot be greater than Max GPA.");
        }
  
        console.log("Currently Enrolled:", edu.isCurrent);
      }
    }
  }
  