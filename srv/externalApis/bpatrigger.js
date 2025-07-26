import axios from 'axios';

export default async function triggerBpa(jobData) {

    console.log("jOdata in bpa", jobData)
    console.log("Job title", jobData.jobTitle);


    try {
        const tokenRes = await axios.post('https://5bd9c330trial.authentication.us10.hana.ondemand.com/oauth/token', null, {
            params: {
                client_id: 'sb-61161fc2-24a9-4f0e-9c6c-1a889a6dc03c!b481123|xsuaa!b49390',
                client_secret: '1a5a4045-f9b7-4290-8dca-c6c874075b7d$vYIhQCKzg7sVW39Qf2HQoui7pF1jSCjQ3T1LVYWyrOo=',
                grant_type: 'client_credentials'
            }
        });

        const accessToken = tokenRes.data.access_token;
        console.log("Access Token Is", accessToken);

        const payload = {
            definitionId: 'us10.5bd9c330trial.jobrequisitionapproval.jobRequisitionHandlingProcess',
            context: {
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
                noOfPositions: jobData.noOfPositions,
                urgency: jobData.urgency,
                requiredSkills: jobData.requiredSkills,
                minimumSalary: jobData.minimumSalary,
                maximumSalary: jobData.maximumSalary,
                currency: jobData.currency,
                hiringManager: jobData.hiringManager,
                postingDate: jobData.postingDate,
                preferredQualifications: jobData.preferredQualifications
            }
        };

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



        // const bpaResponse = await axios.post(
        //     'https://workflow-us10.cfapps.us10.hana.ondemand.com/workflow-service/rest/v1/workflow-instances',
        //     {
        //         definitionId: "us10.5bd9c330trial.jobrequisitionapproval.jobRequisitionHandlingProcess",
        //         context: {
        //             requisitionNumber: "REQ-12345",
        //             jobTitle: "Full Stack Developer",
        //             jobDescription: "Develop and maintain web apps",
        //             department: "IT",

        //             employmentType: "Full-Time",

        //             location: "Hyderabad",

        //             experienceLevel: "Mid",

        //             recruiter: "Anjali Reddy",

        //             applicationDeadline: "2025-08-15",

        //             status: "Pending",

        //             noOfPositions: "2",

        //             urgency: "High",

        //             requiredSkills: "React, Node.js, MongoDB",

        //             minimumSalary: "800000",

        //             maximumSalary: "1200000",

        //             currency: "INR",

        //             hiringManager: "Rahul Sharma",

        //             postingDate: "2025-07-26",

        //             preferredQualifications: "MCA or B.Tech"

        //         }

        //     },

        //     {

        //         headers: {

        //             Authorization: `Bearer ${accessToken}`,

        //             'Content-Type': 'application/json'

        //         }

        //     }

        // );

        console.log("Response Data", bpaResponse.data);
        return bpaResponse.data;

    } catch (e) {
        console.log("Error While triggering the BPA", e);
        return e;
    }
}
