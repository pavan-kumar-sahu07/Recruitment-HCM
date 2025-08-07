using CandidateService as service from '../../srv/candidateservice';
using from '../../srv/requisitionservice';
using from '../../db/recruitment';


annotate RequisitionService.JobRequisition with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : requisitionNumber,
        },
        {
            $Type : 'UI.DataField',
            Value : requiredSkills,
        },
        {
            $Type : 'UI.DataField',
            Value : salaryRangeMax,
        },
        {
            $Type : 'UI.DataField',
            Value : salaryRangeMin,
        },
        {
            $Type : 'UI.DataField',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Value : department,
        },
        {
            $Type : 'UI.DataField',
            Value : employmentType,
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>JobrequistionsDetails}',
            ID : 'GeneralInformation',
            Target : '@UI.FieldGroup#GeneralInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Job Applications',
            ID : 'JobApplications',
            Target : 'applications/@UI.LineItem#JobApplications',
        },
    ],
    UI.FieldGroup #GeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : jobTitle,
            },
            {
                $Type : 'UI.DataField',
                Value : department,
            },
            {
                $Type : 'UI.DataField',
                Value : employmentType,
            },
            {
                $Type : 'UI.DataField',
                Value : experienceLevel,
            },
            {
                $Type : 'UI.DataField',
                Value : applicationDeadline,
            },
            {
                $Type : 'UI.DataField',
                Value : location,
            },
            {
                $Type : 'UI.DataField',
                Value : hiringManager,
            },
            {
                $Type : 'UI.DataField',
                Value : jobDescription,
            },
            {
                $Type : 'UI.DataField',
                Value : numberOfPositions,
            },
            {
                $Type : 'UI.DataField',
                Value : currency_code,
            },
            {
                $Type : 'UI.DataField',
                Value : postingDate,
            },
            {
                $Type : 'UI.DataField',
                Value : preferredQualifications,
            },
            {
                $Type : 'UI.DataField',
                Value : recruiter,
            },
            {
                $Type : 'UI.DataField',
                Value : requiredSkills,
            },
            {
                $Type : 'UI.DataField',
                Value : salaryRangeMax,
            },
            {
                $Type : 'UI.DataField',
                Value : salaryRangeMin,
            },
            {
                $Type : 'UI.DataField',
                Value : status,
            },
            {
                $Type : 'UI.DataField',
                Value : urgency,
            },
        ],
    },
    UI.HeaderInfo : {
        TypeNamePlural : 'Job Requistions',
        TypeName : '',
        TypeImageUrl : 'sap-icon://business-card',
    },
    UI.SelectionFields : [
        employmentType,
        experienceLevel,
        status,
        urgency,
    ],
);

annotate RequisitionService.JobApplication with @(
    UI.LineItem #JobApplications : [
        {
            $Type : 'UI.DataField',
            Value : applicationNumber,
        },
        {
            $Type : 'UI.DataField',
            Value : jobRequisition_ID,
            Label : 'jobRequisition_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : candidate_ID,
            Label : 'candidate_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : applicationDate,
        },
        {
            $Type : 'UI.DataField',
            Value : referredBy,
        },
        {
            $Type : 'UI.DataField',
            Value : overallRating,
        },
        {
            $Type : 'UI.DataField',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Value : coverLetter,
        },
        {
            $Type : 'UI.DataField',
            Value : source,
        },
        {
            $Type : 'UI.DataField',
            Value : portfolioURL,
        },
        {
            $Type : 'UI.DataField',
            Value : resumeURL,
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Job Application Details',
            ID : 'JobApplicationDetails',
            Target : '@UI.FieldGroup#JobApplicationDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Job Interviews',
            ID : 'JobInterviews',
            Target : 'interviews/@UI.LineItem#JobInterviews',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Job Offers',
            ID : 'JobOffers',
            Target : 'offers/@UI.LineItem#JobOffers',
        },
    ],
    UI.FieldGroup #JobApplicationDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : applicationDate,
            },
            {
                $Type : 'UI.DataField',
                Value : candidate_ID,
                Label : 'candidate_ID',
            },
            {
                $Type : 'UI.DataField',
                Value : coverLetter,
            },
            {
                $Type : 'UI.DataField',
                Value : jobRequisition_ID,
                Label : 'jobRequisition_ID',
            },
            {
                $Type : 'UI.DataField',
                Value : overallRating,
            },
            {
                $Type : 'UI.DataField',
                Value : portfolioURL,
            },
            {
                $Type : 'UI.DataField',
                Value : referredBy,
            },
            {
                $Type : 'UI.DataField',
                Value : resumeURL,
            },
            {
                $Type : 'UI.DataField',
                Value : source,
            },
            {
                $Type : 'UI.DataField',
                Value : status,
            },
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : jobRequisition.jobTitle,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
);

annotate RequisitionService.JobApplicationInterview with @(
    UI.LineItem #JobInterviews : [
        {
            $Type : 'UI.DataField',
            Value : jobApplication_ID,
            Label : 'jobApplication_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : jobApplication.interviews.jobInterviewNumber,
            Label : 'Job Interview Number',
        },
        {
            $Type : 'UI.DataField',
            Value : duration,
        },
        {
            $Type : 'UI.DataField',
            Value : interviewRound,
        },
        {
            $Type : 'UI.DataField',
            Value : interviewer,
        },
        {
            $Type : 'UI.DataField',
            Value : interviewType,
        },
        {
            $Type : 'UI.DataField',
            Value : location,
        },
        {
            $Type : 'UI.DataField',
            Value : rating,
        },
        {
            $Type : 'UI.DataField',
            Value : scheduledDate,
        },
        {
            $Type : 'UI.DataField',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Value : feedback,
        },
        {
            $Type : 'UI.DataField',
            Value : meetingLink,
        },
        {
            $Type : 'UI.DataField',
            Value : notes,
        },
    ]
);

annotate RequisitionService.JobOffer with @(
    UI.LineItem #JobOffers : [
        {
            $Type : 'UI.DataField',
            Value : jobApplication_ID,
            Label : 'jobApplication_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : offerNumber,
        },
        {
            $Type : 'UI.DataField',
            Value : jobTitle,
        },
        {
            $Type : 'UI.DataField',
            Value : acceptanceDate,
        },
        {
            $Type : 'UI.DataField',
            Value : baseSalary,
        },
        {
            $Type : 'UI.DataField',
            Value : benefits,
        },
        {
            $Type : 'UI.DataField',
            Value : bonus,
        },
        {
            $Type : 'UI.DataField',
            Value : currency_code,
        },
        {
            $Type : 'UI.DataField',
            Value : department,
        },
        {
            $Type : 'UI.DataField',
            Value : expirationDate,
        },
        {
            $Type : 'UI.DataField',
            Value : offerDate,
        },
        {
            $Type : 'UI.DataField',
            Value : rejectionReason,
        },
        {
            $Type : 'UI.DataField',
            Value : reportingManager,
        },
        {
            $Type : 'UI.DataField',
            Value : startDate,
        },
        {
            $Type : 'UI.DataField',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Value : workArrangement,
        },
        {
            $Type : 'UI.DataField',
            Value : workLocation,
        },
    ]
);

annotate RequisitionService.JobRequisition with {
    employmentType @(
        Common.ValueList : {
            CollectionPath : 'JobEmploymentTypeOptions',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : employmentType,
                    ValueListProperty : 'code',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate RequisitionService.JobRequisition with {
    experienceLevel @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'JobExperienceLevel',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : experienceLevel,
                    ValueListProperty : 'title',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate RequisitionService.JobRequisition with {
    urgency @(
        Common.ValueList : {
            CollectionPath : 'JobUrgencyLevel',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : urgency,
                    ValueListProperty : 'title',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate RequisitionService.JobRequisition with {
    status @(
        Common.ValueList : {
            CollectionPath : 'JobStatusOptions',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status,
                    ValueListProperty : 'title',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate RequisitionService.JobApplication with {
    status @(
        Common.ValueList : {
            CollectionPath : 'ApplicationStatusOptions',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status,
                    ValueListProperty : 'title',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate RequisitionService.JobApplication with {
    source @(
        Common.ValueList : {
            CollectionPath : 'CandidateSourceOptions',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : source,
                    ValueListProperty : 'title',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

