using CandidateService as service from '../../srv/candidateservice';
using from '../../db/recruitment';

annotate service.Candidate with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : candidateNumber,
            },
            {
                $Type : 'UI.DataField',
                Value : firstName,
            },
            {
                $Type : 'UI.DataField',
                Value : lastName,
            },
            {
                $Type : 'UI.DataField',
                Value : middleName,
            },
            {
                $Type : 'UI.DataField',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Value : phone,
            },
            {
                $Type : 'UI.DataField',
                Value : alternatePhone,
            },
            {
                $Type : 'UI.DataField',
                Value : dateOfBirth,
            },
            {
                $Type : 'UI.DataField',
                Label : 'nationality_code',
                Value : nationality_code,
            },
            {
                $Type : 'UI.DataField',
                Value : currentLocation,
            },
            {
                $Type : 'UI.DataField',
                Value : willingToRelocate,
            },
            {
                $Type : 'UI.DataField',
                Value : preferredLocation,
            },
            {
                $Type : 'UI.DataField',
                Value : currentSalary,
            },
            {
                $Type : 'UI.DataField',
                Value : expectedSalary,
            },
            {
                $Type : 'UI.DataField',
                Label : 'currency_code',
                Value : currency_code,
            },
            {
                $Type : 'UI.DataField',
                Value : noticePeriod,
            },
            {
                $Type : 'UI.DataField',
                Value : availabilityDate,
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
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Upload Resume',
            ID : 'UploadResume',
            Target : '@UI.FieldGroup#UploadResume1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Candidate Education',
            ID : 'CandidateEducation',
            Target : 'education/@UI.LineItem#CandidateEducation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Candidate Outsideworkexprience',
            ID : 'CandidateOutsideworkexprience',
            Target : 'workExperienceOutside/@UI.LineItem#CandidateOutsideworkexprience',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Candidate Insideexprience',
            ID : 'CandidateInsideexprience',
            Target : 'workExperienceInside/@UI.LineItem#CandidateInsideexprience',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Candidate Certificates',
            ID : 'CandidateCertificates',
            Target : 'certificates/@UI.LineItem#CandidateCertificates',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Candidate Languages',
            ID : 'CandidateLanguages',
            Target : 'languages/@UI.LineItem#CandidateLanguages',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : candidateNumber,
        },
        {
            $Type : 'UI.DataField',
            Value : firstName,
        },
        {
            $Type : 'UI.DataField',
            Value : lastName,
        },
        {
            $Type : 'UI.DataField',
            Value : middleName,
        },
        {
            $Type : 'UI.DataField',
            Value : email,
        },
    ],
    UI.HeaderInfo : {
        TypeName : '',
        TypeNamePlural : '',
        Initials : firstName,
        Description : {
            $Type : 'UI.DataField',
            Value : 'Candidate Details',
        },
        TypeImageUrl : 'sap-icon://person-placeholder',
    },
    UI.FieldGroup #ResumeUpload : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    },
    UI.FieldGroup #UploadResume : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    },
    UI.FieldGroup #Resume : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : resume.resume,
                Label : 'resume',
            },
        ],
    },
    UI.SelectionFields : [
        source,
        status,
    ],
    UI.FieldGroup #UploadResume1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : resume,
                Label : 'Resume(PDF)',
            },
        ],
    },
);

annotate service.CandidateEducation with @(
    UI.LineItem #CandidateEducation : [
        {
            $Type : 'UI.DataField',
            Value : candidate_ID,
            Label : 'candidate_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : degree,
        },
        {
            $Type : 'UI.DataField',
            Value : fieldOfStudy,
        },
        {
            $Type : 'UI.DataField',
            Value : gpa,
        },
        {
            $Type : 'UI.DataField',
            Value : honors,
        },
        {
            $Type : 'UI.DataField',
            Value : institution,
        },
        {
            $Type : 'UI.DataField',
            Value : isCurrent,
        },
        {
            $Type : 'UI.DataField',
            Value : maxGpa,
        },
        {
            $Type : 'UI.DataField',
            Value : startDate,
        },
        {
            $Type : 'UI.DataField',
            Value : endDate,
        },
        {
            $Type : 'UI.DataField',
            Value : activities,
        },
    ]
);

annotate service.CandidateOutsideWorkExperience with @(
    UI.LineItem #CandidateOutsideworkexprience : [
        {
            $Type : 'UI.DataField',
            Value : company,
        },
        {
            $Type : 'UI.DataField',
            Value : startDate,
        },
        {
            $Type : 'UI.DataField',
            Value : endDate,
        },
        {
            $Type : 'UI.DataField',
            Value : isCurrent,
        },
        {
            $Type : 'UI.DataField',
            Value : jobTitle,
        },
        {
            $Type : 'UI.DataField',
            Value : responsibilities,
        },
        {
            $Type : 'UI.DataField',
            Value : salary,
        },
        {
            $Type : 'UI.DataField',
            Value : reasonForLeaving,
        },
        {
            $Type : 'UI.DataField',
            Value : currency_code,
        },
        {
            $Type : 'UI.DataField',
            Value : achievements,
        },
        {
            $Type : 'UI.DataField',
            Value : candidate_ID,
            Label : 'candidate_ID',
        },
    ]
);

annotate service.CandidateInsideWorkExperience with @(
    UI.LineItem #CandidateInsideexprience : [
        {
            $Type : 'UI.DataField',
            Value : candidate_ID,
            Label : 'candidate_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : startDate,
        },
        {
            $Type : 'UI.DataField',
            Value : endDate,
        },
        {
            $Type : 'UI.DataField',
            Value : responsibilities,
        },
        {
            $Type : 'UI.DataField',
            Value : company,
        },
        {
            $Type : 'UI.DataField',
            Value : achievements,
        },
        {
            $Type : 'UI.DataField',
            Value : currency_code,
        },
        {
            $Type : 'UI.DataField',
            Value : isCurrent,
        },
        {
            $Type : 'UI.DataField',
            Value : jobTitle,
        },
        {
            $Type : 'UI.DataField',
            Value : salary,
        },
        {
            $Type : 'UI.DataField',
            Value : reasonForLeaving,
        },
    ]
);

annotate service.CandidateCertificate with @(
    UI.LineItem #CandidateCertificates : [
        {
            $Type : 'UI.DataField',
            Value : candidate_ID,
            Label : 'candidate_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : certificateName,
        },
        {
            $Type : 'UI.DataField',
            Value : credentialID,
        },
        {
            $Type : 'UI.DataField',
            Value : credentialURL,
        },
        {
            $Type : 'UI.DataField',
            Value : expirationDate,
        },
        {
            $Type : 'UI.DataField',
            Value : isActive,
        },
        {
            $Type : 'UI.DataField',
            Value : issueDate,
        },
        {
            $Type : 'UI.DataField',
            Value : issuingOrganization,
        },
    ]
);

annotate service.CandidateLanguage with @(
    UI.LineItem #CandidateLanguages : [
        {
            $Type : 'UI.DataField',
            Value : candidate_ID,
            Label : 'candidate_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : isNative,
        },
        {
            $Type : 'UI.DataField',
            Value : language_code,
        },
        {
            $Type : 'UI.DataField',
            Value : listeningLevel,
        },
        {
            $Type : 'UI.DataField',
            Value : proficiencyLevel,
        },
        {
            $Type : 'UI.DataField',
            Value : readingLevel,
        },
        {
            $Type : 'UI.DataField',
            Value : speakingLevel,
        },
        {
            $Type : 'UI.DataField',
            Value : writingLevel,
        },
    ]
);

annotate service.Candidate with {
    availabilityDate @(
        Common.Label : '{i18n>AvailabilityDate}',
        )
};

annotate service.Candidate with {
    status @(
        Common.ValueList : {
            CollectionPath : 'CandidateStatusOptions',
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

annotate service.Candidate with {
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

annotate service.CandidateLanguage with {
    listeningLevel @(
        Common.ValueListWithFixedValues : true,
        Common.ValueList : {
            CollectionPath : 'ProficiencyLevelOptions',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : listeningLevel,
                    ValueListProperty : 'title',
                },
            ],
        },
    )
};

annotate service.CandidateLanguage with {
    proficiencyLevel @(
        Common.ValueList : {
            CollectionPath : 'ProficiencyLevelOptions',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : proficiencyLevel,
                    ValueListProperty : 'title',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.CandidateLanguage with {
    readingLevel @(
        Common.ValueList : {
            CollectionPath : 'ProficiencyLevelOptions',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : readingLevel,
                    ValueListProperty : 'title',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.CandidateLanguage with {
    writingLevel @(
        Common.ValueList : {
            CollectionPath : 'ProficiencyLevelOptions',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : writingLevel,
                    ValueListProperty : 'title',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.CandidateLanguage with {
    speakingLevel @(
        Common.ValueList : {
            CollectionPath : 'ProficiencyLevelOptions',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : speakingLevel,
                    ValueListProperty : 'title',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

