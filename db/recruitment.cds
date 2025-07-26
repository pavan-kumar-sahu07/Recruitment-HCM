namespace sap.hcm.recruiting;

using {
    Currency,
    Country,
    Language,
    User,
    managed,
    temporal,
    sap.common.CodeList
} from '@sap/cds/common';


/**
 * Job Requisition - Represents job openings and requirements
 */


entity JobEmploymentTypeOptions : CodeList {
    key code  : String(50);
        title : String(100);
}


entity JobExperienceLevel : CodeList {
    key code  : String(50);
        title : String(100);
}


entity JobUrgencyLevel : CodeList {
    key code  : String(50);
        title : String(100);
}


entity JobStatusOptions : CodeList {
    key code  : String(50);
        title : String(100);
}


@odata.draft.enabled
entity JobRequisition : managed {
    key ID                      : UUID;

        @readonly
        requisitionNumber       : String(20)     @title: 'Requisition Number';

        @mandatory
        jobTitle                : String(255)    @title: 'Job Title';

        @mandatory
        jobDescription          : LargeString    @title: 'Job Description';

        @mandatory
        department              : String(100)    @title: 'Department';

        @mandatory
        location                : String(100)    @title: 'Location';


        @Common.ValueList: {
            CollectionPath: 'JobEmploymentTypeOptions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'employmentType',
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                }
            ]
        }
        @mandatory
        employmentType          : String(50)     @title: 'Employment Type';

        @Common.ValueList: {
            CollectionPath: 'JobExperienceLevel',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'experienceLevel',
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                }
            ]
        }
        @mandatory
        experienceLevel         : String(50)     @title: 'Experience Level';

        salaryRangeMin          : Decimal(15, 2) @title: 'Minimum Salary';
        salaryRangeMax          : Decimal(15, 2) @title: 'Maximum Salary';
        currency                : Currency       @title: 'Currency';
        numberOfPositions       : Integer        @title: 'Number of Positions';


        @Common.ValueList: {
            CollectionPath: 'JobUrgencyLevel',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'urgency',
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                }
            ]
        }
        urgency                 : String(20)     @title: 'Urgency';


        @Common.ValueList: {
            CollectionPath: 'JobStatusOptions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'status',
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                }
            ]
        }
        status                  : String(20)     @title: 'Status';

        postingDate             : Date           @title: 'Posting Date';
        applicationDeadline     : Date           @title: 'Application Deadline';
        hiringManager           : String(100)    @title: 'Hiring Manager';
        recruiter               : String(100)    @title: 'Recruiter';
        requiredSkills          : LargeString    @title: 'Required Skills';
        preferredQualifications : LargeString    @title: 'Preferred Qualifications';


        applications            : Composition of many JobApplication
                                      on applications.jobRequisition = $self;
}


/**
 * Candidate - Core candidate information
 */


entity CandidateStatusOptions : CodeList {
    key code  : String(10);
        title : String(100);

}

entity CandidateSourceOptions : CodeList {
    key code  : String(10);
        title : String(100);
}

entity Candidate : managed {
    key ID                    : UUID;

        @readonly
        candidateNumber       : String(20)     @title: 'Candidate Number';

        @mandatory
        firstName             : String(100)    @title: 'First Name';

        @mandatory
        lastName              : String(100)    @title: 'Last Name';

        @mandatory
        middleName            : String(100)    @title: 'Middle Name';

        @mandatory
        email                 : String(255)    @title: 'Email Address';

        @mandatory
        @assert.pattern  : '^\\+?[0-9]{10,15}$'
        phone                 : String(20)     @title: 'Phone Number';

        @mandatory
        alternatePhone        : String(20)     @title: 'Alternate Phone';

        @mandatory
        dateOfBirth           : Date           @title: 'Date of Birth';
        nationality           : Country        @title: 'Nationality';
        currentLocation       : String(100)    @title: 'Current Location';
        willingToRelocate     : Boolean        @title: 'Willing to Relocate';
        preferredLocation     : String(100)    @title: 'Preferred Location';
        currentSalary         : Decimal(15, 2) @title: 'Current Salary';
        expectedSalary        : Decimal(15, 2) @title: 'Expected Salary';
        currency              : Currency       @title: 'Currency';
        noticePeriod          : Integer        @title: 'Notice Period (Days)';
        availabilityDate      : Date           @title: 'Availability Date';


        @title           : 'Source'
        @Common.ValueList: {
            CollectionPath: 'CandidateSourceOptions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'source',
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                }
            ]
        }
        source                : String(100); // Job Board, Referral, Direct, etc.

        @title           : 'Status'
        @Common.ValueList: {
            CollectionPath: 'CandidateStatusOptions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'status',
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                }
            ]
        }
        status                : String(20);

        @Core.MediaType: 'application/pdf'
        resume                : LargeBinary;
        // Associations
        applications          : Composition of many JobApplication
                                    on applications.candidate = $self;
        // background                     : Composition of one CandidateBackground on background.candidate = $self;
        education             : Composition of many CandidateEducation
                                    on education.candidate = $self;
        workExperienceOutside : Composition of many CandidateOutsideWorkExperience
                                    on workExperienceOutside.candidate = $self;
        workExperienceInside  : Composition of many CandidateInsideWorkExperience
                                    on workExperienceInside.candidate = $self;
        certificates          : Composition of many CandidateCertificate
                                    on certificates.candidate = $self;
        languages             : Composition of many CandidateLanguage
                                    on languages.candidate = $self;
        comments              : Composition of many CandidateComment
                                    on comments.candidate = $self;
        tags                  : Composition of many CandidateTag
                                    on tags.candidate = $self;
        profileExtensions     : Composition of many CandidateProfileExtension
                                    on profileExtensions.candidate = $self;
}


/**
 * Candidate Education Details
 */
entity CandidateEducation : managed {
    key ID           : UUID;

        candidate    : Association to Candidate;

        @mandatory
        institution  : String(255)   @title: 'Institution';

        @mandatory
        degree       : String(100)   @title: 'Degree';

        @mandatory
        fieldOfStudy : String(100)   @title: 'Field of Study';

        @mandatory
        startDate    : Date          @title: 'Start Date';

        @mandatory
        endDate      : Date          @title: 'End Date';

        @mandatory
        gpa          : Decimal(3, 2) @title: 'GPA';

        @mandatory
        maxGpa       : Decimal(3, 2) @title: 'Max GPA';
        honors       : String(255)   @title: 'Honors/Awards';
        activities   : LargeString   @title: 'Activities';
        isCurrent    : Boolean       @title: 'Currently Enrolled';
}

/**
 * Candidate Outside Work Experience
 */
entity CandidateOutsideWorkExperience : managed {
    key ID               : UUID;

        candidate        : Association to Candidate;

        @mandatory
        company          : String(255)    @title: 'Company';

        @mandatory
        jobTitle         : String(255)    @title: 'Job Title';

        @mandatory
        startDate        : Date           @title: 'Start Date';

        endDate          : Date           @title: 'End Date';

        isCurrent        : Boolean        @title: 'Current Position';

        @mandatory
        responsibilities : LargeString    @title: 'Responsibilities';
        achievements     : LargeString    @title: 'Achievements';
        reasonForLeaving : String(255)    @title: 'Reason for Leaving';

        @mandatory
        salary           : Decimal(15, 2) @title: 'Salary';
        currency         : Currency       @title: 'Currency';
}

/**
 * Candidate Inside Work Experience (within the organization)
 */
entity CandidateInsideWorkExperience : managed {
    key ID               : UUID;

        candidate        : Association to Candidate;

        @mandatory
        company          : String(255)    @title: 'Company';

        @mandatory
        jobTitle         : String(255)    @title: 'Job Title';

        @mandatory
        startDate        : Date           @title: 'Start Date';

        endDate          : Date           @title: 'End Date';

        isCurrent        : Boolean        @title: 'Current Position';

        @mandatory
        responsibilities : LargeString    @title: 'Responsibilities';
        achievements     : LargeString    @title: 'Achievements';
        reasonForLeaving : String(255)    @title: 'Reason for Leaving';

        @mandatory
        salary           : Decimal(15, 2) @title: 'Salary';
        currency         : Currency       @title: 'Currency';
}

/**
 * Candidate Certificates and Certifications
 */
entity CandidateCertificate : managed {
    key ID                  : UUID;

        candidate           : Association to Candidate;

        @mandatory
        certificateName     : String(255) @title: 'Certificate Name';

        @mandatory
        issuingOrganization : String(255) @title: 'Issuing Organization';

        @mandatory
        issueDate           : Date        @title: 'Issue Date';

        @mandatory
        expirationDate      : Date        @title: 'Expiration Date';
        credentialID        : String(100) @title: 'Credential ID';
        credentialURL       : String(500) @title: 'Credential URL';
        isActive            : Boolean     @title: 'Is Active';
}

/**
 * Candidate Language Skills
 */


entity ProficiencyLevelOptions : CodeList {
    key code  : String(20);
        title : String(100);
}

entity CandidateLanguage : managed {
    key ID               : UUID;
        candidate        : Association to Candidate;
        language         : Language   @title: 'Language';

        @Common.ValueList: {
            CollectionPath: 'ProficiencyLevelOptions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'proficiencyLevel',
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                }
            ]
        }
        proficiencyLevel : String(20) @title: 'Proficiency Level';

        @Common.ValueList: {
            CollectionPath: 'ProficiencyLevelOptions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'readingLevel',
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                }
            ]
        }
        readingLevel     : String(20) @title: 'Reading Level';

        @Common.ValueList: {
            CollectionPath: 'ProficiencyLevelOptions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'writingLevel',
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                }
            ]
        }
        writingLevel     : String(20) @title: 'Writing Level';

        @Common.ValueList: {
            CollectionPath: 'ProficiencyLevelOptions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'speakingLevel',
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                }
            ]
        }
        speakingLevel    : String(20) @title: 'Speaking Level';

        @Common.ValueList: {
            CollectionPath: 'ProficiencyLevelOptions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'listeningLevel',
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                }
            ]
        }
        listeningLevel   : String(20) @title: 'Listening Level';

        isNative         : Boolean    @title: 'Native Language';
}

/**
 * Job Application - Links candidates to job requisitions
 */

entity ApplicationStatusOptions : CodeList {

    key code  : String;
        title : String;
}

entity JobApplication : managed {
    key ID                : UUID;

        @readonly
        applicationNumber : String(20)    @title: 'Application Number';

        @Common.ValueList: {
            CollectionPath: 'Candidate',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'candidate_ID',
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'firstName'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'lastName'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'email'
                }
            ]
        }
        candidate         : Association to Candidate;

        // candidate         : Association to Candidate;
        jobRequisition    : Association to JobRequisition;
        applicationDate   : Date          @title: 'Application Date';

        @Common.ValueList: {
            CollectionPath: 'ProficiencyLevelOptions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'status',
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                }
            ]
        }
        status            : String(20)    @title: 'Status';

        @Common.ValueList: {
            CollectionPath: 'CandidateSourceOptions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'source',
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                }
            ]
        }
        source            : String(100)   @title: 'Application Source';

        //source            : String(100)   @title: 'Application Source';
        coverLetter       : LargeString   @title: 'Cover Letter URL';
        resumeURL         : String(500)   @title: 'Resume URL';
        portfolioURL      : String(500)   @title: 'Portfolio URL';
        referredBy        : String(100)   @title: 'Referred By';
        currentStage      : String(50)    @title: 'Current Stage';
        overallRating     : Decimal(3, 2) @title: 'Overall Rating';

        // Associations
        interviews        : Composition of many JobApplicationInterview
                                on interviews.jobApplication = $self;
        offers            : Composition of many JobOffer
                                on offers.jobApplication = $self;
        snapshots         : Composition of many JobApplicationSnapshot
                                on snapshots.jobApplication = $self;
}

/**
 * Job Application Interview Details
 */
entity JobApplicationInterview : managed {
    key ID                     : UUID;
        jobApplication         : Association to JobApplication;
        interviewType          : String(50)    @title: 'Interview Type'; // Phone, Video, In-Person, Panel
        interviewRound         : Integer       @title: 'Interview Round';
        scheduledDate          : DateTime      @title: 'Scheduled Date';
        actualDate             : DateTime      @title: 'Actual Date';
        duration               : Integer       @title: 'Duration (Minutes)';
        location               : String(255)   @title: 'Location';
        meetingLink            : String(500)   @title: 'Meeting Link';
        interviewer            : String(100)   @title: 'Primary Interviewer';
        additionalInterviewers : String(500)   @title: 'Additional Interviewers';
        status                 : String(20)    @title: 'Status';
        feedback               : LargeString   @title: 'Interview Feedback';
        rating                 : Decimal(3, 2) @title: 'Interview Rating';
        recommendation         : String(20)    @title: 'Recommendation';
        notes                  : LargeString   @title: 'Additional Notes';
}

/**
 * Job Offer Details
 */
entity JobOffer : managed {
    key ID               : UUID;
        offerNumber      : String(20)     @title: 'Offer Number';
        jobApplication   : Association to JobApplication;
        offerDate        : Date           @title: 'Offer Date';
        expirationDate   : Date           @title: 'Expiration Date';
        status           : String(20)     @title: 'Status';
        jobTitle         : String(255)    @title: 'Job Title';
        department       : String(100)    @title: 'Department';
        startDate        : Date           @title: 'Start Date';
        baseSalary       : Decimal(15, 2) @title: 'Base Salary';
        currency         : Currency       @title: 'Currency';
        bonus            : Decimal(15, 2) @title: 'Bonus';
        benefits         : LargeString    @title: 'Benefits Package';
        workLocation     : String(255)    @title: 'Work Location';
        workArrangement  : String(50)     @title: 'Work Arrangement';
        reportingManager : String(100)    @title: 'Reporting Manager';
        offerLetter      : LargeString    @title: 'Offer Letter Content';
        terms            : LargeString    @title: 'Terms and Conditions';
        acceptanceDate   : Date           @title: 'Acceptance Date';
        rejectionReason  : String(255)    @title: 'Rejection Reason';
}

/**
 * Job Application Snapshot - Historical data capture
 */
entity JobApplicationSnapshot : managed {
    key ID             : UUID;
        jobApplication : Association to JobApplication;
        snapshotDate   : DateTime   @title: 'Snapshot Date';
        snapshotType   : String(50) @title: 'Snapshot Type';

        // Snapshot of candidate data at time of application
        education      : Composition of many JobApplicationSnapshotEducation
                             on education.snapshot = $self;
        certificates   : Composition of many JobApplicationSnapshotCertificate
                             on certificates.snapshot = $self;
}

/**
 * Job Application Snapshot - Education
 */
entity JobApplicationSnapshotEducation : managed {
    key ID             : UUID;
        snapshot       : Association to JobApplicationSnapshot;
        institution    : String(255)   @title: 'Institution';
        degree         : String(100)   @title: 'Degree';
        fieldOfStudy   : String(100)   @title: 'Field of Study';
        graduationDate : Date          @title: 'Graduation Date';
        gpa            : Decimal(3, 2) @title: 'GPA';
}

/**
 * Job Application Snapshot - Certificates
 */
entity JobApplicationSnapshotCertificate : managed {
    key ID                  : UUID;
        snapshot            : Association to JobApplicationSnapshot;
        certificateName     : String(255) @title: 'Certificate Name';
        issuingOrganization : String(255) @title: 'Issuing Organization';
        issueDate           : Date        @title: 'Issue Date';
        expirationDate      : Date        @title: 'Expiration Date';
}


/**
 * Candidate Comments and Notes
 */
entity CandidateComment : managed {
    key ID          : UUID;
        candidate   : Association to Candidate;
        commentDate : DateTime    @title: 'Comment Date';
        commentBy   : User        @title: 'Comment By';
        commentType : String(50)  @title: 'Comment Type'; // General, Interview, Reference
        comment     : LargeString @title: 'Comment';
        isPrivate   : Boolean     @title: 'Private Comment';
        visibility  : String(20)  @title: 'Visibility'; // Public, Team, Private
}

/**
 * Candidate Tags for categorization
 */
entity CandidateTag : managed {
    key ID          : UUID;
        candidate   : Association to Candidate;
        tagName     : String(100) @title: 'Tag Name';
        tagCategory : String(50)  @title: 'Tag Category';
        tagValue    : String(255) @title: 'Tag Value';
        addedBy     : User        @title: 'Added By';
        addedDate   : DateTime    @title: 'Added Date';
}

/**
 * Candidate Profile Extensions for custom fields
 */
entity CandidateProfileExtension : managed {
    key ID            : UUID;
        candidate     : Association to Candidate;
        fieldName     : String(100) @title: 'Field Name';
        fieldType     : String(20)  @title: 'Field Type';
        fieldValue    : String(500) @title: 'Field Value';
        fieldCategory : String(50)  @title: 'Field Category';
        isRequired    : Boolean     @title: 'Required Field';
        displayOrder  : Integer     @title: 'Display Order';
}

/**
 * Candidate Light - Simplified candidate view for performance
 */
entity CandidateLight {
    key ID               : UUID;
        candidateNumber  : String(20)  @title: 'Candidate Number';
        fullName         : String(255) @title: 'Full Name';
        email            : String(255) @title: 'Email';
        phone            : String(20)  @title: 'Phone';
        status           : String(20)  @title: 'Status';
        source           : String(100) @title: 'Source';
        applicationCount : Integer     @title: 'Application Count';
        lastActivity     : DateTime    @title: 'Last Activity';
}

// ============================================================================
// VIEWS AND PROJECTIONS
// ============================================================================

/**
 * Active Recruitment Pipeline View
 */
view ActiveRecruitmentPipeline as
    select from JobRequisition {
        ID,
        requisitionNumber,
        jobTitle,
        department,
        status,
        numberOfPositions,
        postingDate,
        applicationDeadline,
        hiringManager,
        recruiter,
        applications.ID as applicationCount : Integer
    }
    where
        status in (
            'Open', 'On Hold'
        );

/**
 * Candidate Application Summary View
 */
view CandidateApplicationSummary as
    select from Candidate {
        ID,
        candidateNumber,
        firstName,
        lastName,
        email,
        status,
        applications.ID                       as totalApplications : Integer,
        applications[status = 'Interview'].ID as interviewStage    : Integer,
        applications[status = 'Offer'].ID     as offerStage        : Integer
    };

/**
 * Interview Schedule View
 */
view InterviewSchedule as
    select from JobApplicationInterview {
        ID,
        jobApplication.candidate.firstName,
        jobApplication.candidate.lastName,
        jobApplication.jobRequisition.jobTitle,
        interviewType,
        scheduledDate,
        interviewer,
        status,
        location,
        meetingLink
    }
    where
            status        =  'Scheduled'
        and scheduledDate >= $now;
