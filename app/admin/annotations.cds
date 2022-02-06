using AdminService as service from '../../srv/admin-service';

annotate service.Users with @(
    UI.LineItem   : [{
        $Type : 'UI.DataField',
        Value : FirstName,
        Label : '{@i18n>@Name}',
    }],
    UI.HeaderInfo : {
        TypeName       : 'User',
        TypeNamePlural : 'Users',
        Title          : {
            $Type : 'UI.DataField',
            Value : FirstName
        },
    },
);

annotate service.Tshirts with @(
    UI.PresentationVariant : {
        GroupBy        : [Grp],
        Visualizations : ['@UI.LineItem', ]
    },
    UI.LineItem            : [
        {
            $Type : 'UI.DataField',
            Value : Name,
            Label : '{@i18n>@Name}',
        },
        {
            $Type : 'UI.DataField',
            Value : Grp,
            Label : '{@i18n>@Grp}',
        }
    ],
    UI.HeaderInfo          : {
        TypeName       : 'Tshirt',
        TypeNamePlural : 'Tshirts',
        Title          : {
            $Type : 'UI.DataField',
            Value : Name
        },
    },
);

annotate service.Registrations with @(
    UI.LineItem            : [{
        $Type : 'UI.DataField',
        Value : FirstName,
        Label : '{@i18n>@Name}',
    }],
    UI.HeaderInfo          : {
        TypeName       : 'Registration',
        TypeNamePlural : 'Registrations',
        Title          : {
            $Type : 'UI.DataField',
            Value : FirstName
        },
    },
    UI.Identification      : [
        {
            $Type  : 'UI.DataFieldForAction',
            Label  : 'Create User',
            Action : 'AdminService.createUser',
        },
        {
            $Type  : 'UI.DataFieldForAction',
            Label  : 'Resend Mail',
            Action : 'AdminService.resendMail',
        }
    ],
    UI.FieldGroup #User    : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Value : FirstName,
                Label : '{@i18n>@FirstName}',
            },
            {
                $Type : 'UI.DataField',
                Value : LastName,
                Label : '{@i18n>@LastName}',
            }
        ]
    },
    UI.FieldGroup #Project : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Value : Name,
                Label : '{@i18n>@Name}',
            },
            {
                $Type : 'UI.DataField',
                Value : Description,
                Label : '{@i18n>@Description}',
            },
            {
                $Type : 'UI.DataField',
                Value : ProjectType,
                Label : '{@i18n>@ProjectType}',
            },
            {
                $Type : 'UI.DataField',
                Value : InternalInfo,
                Label : '{@i18n>@InternalInfo}',
            },
            {
                $Type : 'UI.DataField',
                Value : Language.name,
                Label : '{@i18n>@Language}',
            },
            {
                $Type : 'UI.DataField',
                Value : MaxTokens,
                Label : '{@i18n>@MaxTokens}',
            },
        ]
    },
    UI.Facets              : [
        {
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#User',
            Label  : 'User'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Project',
            Label  : 'Project'
        }
    ]
);

annotate service.Questions with @(
    UI.LineItem         : [
        {
            $Type : 'UI.DataField',
            Value : Name,
            Label : '{@i18n>@Name}',
        },
        {
            $Type : 'UI.DataField',
            Value : Description,
            Label : '{@i18n>@Description}',
        }
    ],
    UI.HeaderInfo       : {
        TypeName       : 'Question',
        TypeNamePlural : 'Questions',
        Title          : {
            $Type : 'UI.DataField',
            Value : Name
        },
    },
    UI.FieldGroup #Main : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Value : Name,
                Label : '{@i18n>@Name}',
            },
            {
                $Type : 'UI.DataField',
                Value : Description,
                Label : '{@i18n>@Description}',
            },
            {
                $Type : 'UI.DataField',
                Value : NegativeAnswer,
                Label : '{@i18n>@NegativeAnswer}',
            },
            {
                $Type : 'UI.DataField',
                Value : PositiveAnswer,
                Label : '{@i18n>@PositiveAnswer}',
            },
            {
                $Type : 'UI.DataField',
                Value : Mandatory,
                Label : '{@i18n>@Mandatory}',
            }
        ]
    },
    UI.Facets           : [{
        $Type  : 'UI.ReferenceFacet',
        ID     : 'GeneratedFacet2',
        Target : '@UI.FieldGroup#Main',
        Label  : 'Main'
    }]
);


annotate service.Events with @(
    UI.LineItem                  : [
        {
            $Type : 'UI.DataField',
            Label : 'Title',
            Value : Title,
        },
        {
            $Type : 'UI.DataField',
            Label : 'BeginDate',
            Value : BeginDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'EndDate',
            Value : EndDate,
        }
    ],

    UI.HeaderInfo                : {
        TypeName       : 'Event',
        TypeNamePlural : 'Events',
        Title          : {
            $Type : 'UI.DataField',
            Value : Title
        },
    },
    UI.DataPoint #Totals         : {
        Value        : TotalRegistrations.TotalRegistrations,
        Title        : '{@i18n>@Total}',
        Description  : 'Totals',
        TargetValue  : TotalRegistrations.RemainingRegistrations,
        MaximumValue : MaxRegistration,
    },
    UI.Chart #Totals             : {
        $Type             : 'UI.ChartDefinitionType',
        Title             : '{@i18n>@PercentageFilled}',
        ChartType         : #Donut,
        Measures          : [TotalRegistrations.TotalRegistrations, ],
        MeasureAttributes : [{
            $Type     : 'UI.ChartMeasureAttributeType',
            Measure   : TotalRegistrations.TotalRegistrations,
            DataPoint : '@UI.DataPoint#Totals'
        }]
    },
    UI.DataPoint #ComparisonPath : {
        Value       : TotalRegistrations.TotalRegistrations
    },
    UI.Chart #DistinctSex        : {
        $Type             : 'UI.ChartDefinitionType',
        Title             : 'Sex Distribution',
        ChartType         : #Bar,
        Dimensions        : [Title,],
        MeasureAttributes : [{
            $Type     : 'UI.ChartMeasureAttributeType',
            DataPoint : '@UI.DataPoint#ComparisonPath'
        }]
    },
    UI.FieldGroup #Header        : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Value : BeginDate,
                Label : '{@i18n>@BeginDate}',
            },
            {
                $Type : 'UI.DataField',
                Value : EndDate,
                Label : '{@i18n>@EndDate}',
            },
            {
                $Type : 'UI.DataField',
                Value : TotalRegistrations.RemainingRegistrations,
                Label : '{@i18n>@RemainingRegistrations}',
            },
            {
                $Type : 'UI.DataField',
                Value : TotalRegistrations.TotalRegistrations,
                Label : '{@i18n>@TotalRegistrations}',
            }
        ]
    },

    UI.FieldGroup #Dates         : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Label : 'BeginDate',
                Value : BeginDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'RegistrationOpenDate',
                Value : RegistrationOpenDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'RegistrationClosedDate',
                Value : RegistrationClosedDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ProjectClosedDate',
                Value : ProjectClosedDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'OfficialStartDate',
                Value : OfficialStartDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'EndDate',
                Value : EndDate,
            }
        ],
    },
    UI.FieldGroup #Main          : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Label : 'Title',
                Value : Title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'MaxFileSize',
                Value : MaxFileSize,
            },
            {
                $Type : 'UI.DataField',
                Label : 'MinAge',
                Value : MinAge,
            },
            {
                $Type : 'UI.DataField',
                Label : 'MaxAge',
                Value : MaxAge,
            },
            {
                $Type : 'UI.DataField',
                Label : 'MinGuardianAge',
                Value : MinGuardianAge,
            },
            {
                $Type : 'UI.DataField',
                Label : 'MaxRegistration',
                Value : MaxRegistration,
            },
            {
                $Type : 'UI.DataField',
                Label : 'MaxVoucher',
                Value : MaxVoucher,
            }
        ],
    },
    UI.Facets                    : [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'GeneratedFacet2',
            Target : '@UI.FieldGroup#Main',
            Label  : 'Main'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'GeneratedFacet1',
            Target : '@UI.FieldGroup#Dates',
            Label  : 'Dates'
        },
        {
            $Type  : 'UI.CollectionFacet',
            ID     : 'FurtherData',
            Label  : '{@i18n>@Relations}',
            Facets : [
                {
                    $Type  : 'UI.ReferenceFacet',
                    ID     : 'GeneratedFacet4',
                    Target : 'Questions/@UI.LineItem',
                },
                {
                    $Type  : 'UI.ReferenceFacet',
                    ID     : 'GeneratedFacet7',
                    Target : 'Tshirts/@UI.LineItem',
                },
                {
                    $Type  : 'UI.ReferenceFacet',
                    ID     : 'GeneratedFacet5',
                    Target : 'Users/@UI.LineItem',
                },
                {
                    $Type  : 'UI.ReferenceFacet',
                    ID     : 'GeneratedFacet6',
                    Target : 'Registrations/@UI.LineItem',
                }
            ]
        }
    ],
    UI.HeaderFacets              : [
        {
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Header'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.Chart#Totals'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.Chart#DistinctSex'
        }
    ],
    UI.Identification            : [
        {
            $Type  : 'UI.DataFieldForAction',
            Label  : 'Open Event',
            Action : 'AdminService.openEvent',
        },
        {
            $Type  : 'UI.DataFieldForAction',
            Label  : 'Close Event',
            Action : 'AdminService.closeEvent',
        }
    ]
);
