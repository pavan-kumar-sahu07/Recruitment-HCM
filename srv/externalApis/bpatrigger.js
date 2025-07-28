import axios from 'axios';

export default async function triggerBpa(jobData) {

    console.log("jOdata in bpa", jobData)
    console.log("Job title", jobData.jobTitle);


    try {
        const tokenRes = await axios.post('https://44061ef2trial.authentication.us10.hana.ondemand.com/oauth/token', null, {
            params: {
                client_id: 'sb-8144a7f9-b523-4adf-a766-f19a016f083e!b446630|xsuaa!b49390',
                client_secret: '9b0e7b07-3a83-4320-af36-4e83d0619ab7$RnZRrhobzwn0imdnu8AwwrUGpdvUCIdfKdoMIikx6EA=',
                grant_type: 'client_credentials'
            }
        });

        const accessToken = tokenRes.data.access_token;
        console.log("Access Token Is", accessToken);

        const context = {
            requisitionNumber: jobData.requisitionNumber,
            jobTitle: jobData.jobTitle,
            jobDescription: jobData.jobDescription,
            department: jobData.department,
            employmentType: jobData.employmentType,
            location: jobData.location,
            experienceLevel: jobData.experienceLevel,
            recruiter: jobData.recruiter,
            applicationDeadline: jobData.applicationDeadline,
            status: jobData.status,
            noOfPositions: jobData.numberOfPositions,
            urgency: jobData.urgency,
            requiredSkills: jobData.requiredSkills,
            minimumSalary: jobData.minimumSalary,
            maximumSalary: jobData.maximumSalary,
            currency: jobData.currency,
            hiringManager: jobData.hiringManager,
            postingDate: jobData.postingDate,
            preferredQualifications: jobData.preferredQualifications
          };
      
          
          const stringifiedContext = Object.fromEntries(
            Object.entries(context).map(([key, value]) => [key, value != null ? String(value) : ""])
          );

        const payload= {
            "definitionId": "us10.44061ef2trial.jobrequisition1.jobRequisitionProcess",
            context: stringifiedContext
        }

        const bpaResponse = await axios.post(
            'https://spa-api-gateway-bpi-us-prod.cfapps.us10.hana.ondemand.com/workflow/rest/v1/workflow-instances',
            payload,
            {
                headers: {
                    Authorization: `Bearer ${accessToken}`,
                    'Content-Type': 'application/json'
                }
            }
        );
        console.log("Response Data", bpaResponse.data);
        return bpaResponse.data;

    } catch (e) {
        console.log("Error While triggering the BPA", e);
        return e;
    }
}
