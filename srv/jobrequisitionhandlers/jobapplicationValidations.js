export function validateJobApplicationData(jobsData, req) {

    if (jobsData.applicationDate) {
        const applicationDate = new Date(jobsData.applicationDate);
        applicationDate.setHours(0, 0, 0, 0);

        const today = new Date();
        today.setHours(0, 0, 0, 0);

        if (applicationDate > today) {
          req.error(400, "Application Date cannot be in the future.");
        }
    }
    }
