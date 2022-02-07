namespace be.coolestprojects;

using {
    Country,
    managed,
    Language,
} from '@sap/cds/common';

entity Events {
    key ID                     : UUID;
        Title                  : localized String;
        MaxFileSize            : Integer;
        MinAge                 : Integer;
        MaxAge                 : Integer;
        MinGuardianAge         : Integer;
        MaxRegistration        : Decimal;
        MaxVoucher             : Integer;
        BeginDate              : Date;
        EndDate                : Date;
        RegistrationOpenDate   : Date;
        RegistrationClosedDate : Date;
        ProjectClosedDate      : Date;
        OfficialClosedDate     : Date;
        OfficialStartDate      : Date;
        Users                  : Association to many Users
                                     on Users.Event = $self;
        Questions              : Association to many Questions
                                     on Questions.Event = $self;
        Registrations          : Association to many Registrations
                                     on Registrations.Event = $self;
        Tshirts                : Association to many Tshirts
                                     on Tshirts.Event = $self;

        TotalUsers             : Association to one TotalUsers
                                     on TotalUsers.EventId = ID;

        TotalRegistrations     : Association to one TotalRegistrations
                                     on TotalRegistrations.EventId = ID;
        DistinctSex            : Association to many DistinctSex
                                     on DistinctSex.EventId = ID;
        DistinctTshirt         : Association to many DistinctTshirt
                                     on DistinctTshirt.EventId = ID;

        Sex                    : Association to many Sex
                                     on Sex.Event = $self
}

entity Sex {
    key Event : Association to Events;
    key ID    : UUID;
        Name  : localized String;
}

@readonly
entity TotalRegistrations as
    select from Registrations { 
        key Registrations.Event.ID as EventId,
            count(
                *
            ) as TotalRegistrations,
            Registrations.Event.MaxRegistration - count(
                *
            ) as RemainingRegistrations
    }
    group by
        Registrations.Event.ID;

@readonly
entity TotalUsers         as
    select from Users {
        key Users.Event.ID as EventId,
            count(
                *
            )              as TotalUsers
    }
    group by
        Users.Event.ID;

@readonly
entity DistinctSex        as
    select from Sex
    left join Users
        on  Sex.Event = Users.Event
        and Sex.ID    = Users.Sex.ID
    {
        key Sex.Event.ID as EventId,
        key Sex.ID,
            Sex.Name,
            count(
                Users.ID
            )            as Total
    }
    group by
        Sex.Event.ID,
        Sex.ID;

@readonly
entity DistinctTshirt     as
    select from Tshirts
    left join Users
        on  Tshirts.Event = Users.Event
        and Tshirts.ID    = Users.Tshirt.ID
    {
        key Tshirts.Event.ID as EventId,
        key Tshirts.ID,
            Tshirts.Name,
            count(
                Users.ID
            )            as Total
    }
    group by
        Tshirts.Event.ID,
        Tshirts.ID;


entity Tshirts {
    key ID    : UUID;
        Name  : localized String;
        Grp   : String;
        Event : Association to Events;
}

type UserFields {
    FirstName          : String;
    LastName           : String;
    Tshirt             : Association to Tshirts;
    Language           : Language;
    PostalCode         : Integer;
    MunicipalityName   : String;
    Street             : String;
    HouseNumber        : String;
    BoxNumber          : String;
    Email              : String;
    Sex                : Association to Sex;
    BirthMonth         : Date;
    Via                : String;
    MedicalInformation : String;
    GSM                : String;
    GSMGuardian        : String;
    InternalInfo       : String;
    EmailGuardian      : String;
}

type ProjectFields {
    Name         : String;
    Description  : String;
    ProjectType  : String;
    InternalInfo : String;
    Language     : Language;
    MaxTokens    : Integer;
}

entity Answers {
    key Question : Association to Questions;
}

entity Users : UserFields {
    key ID          : UUID;
        Project     : Association to Projects
                          on Project.Owner = $self;
        Participant : Association to Participations
                          on Participant.Participant = $self;
        Event       : Association to Events;
        Answers     : Composition of Answers;

}

entity Projects : ProjectFields {
    key ID          : UUID;
        Owner       : Association to Users;
        Attachments : Association to Attachments;
}

entity Participations {
    key ID          : UUID;
        Project     : Association to Projects;
        Participant : Association to Users;
}


entity Questions {
    key ID             : UUID;
        Name           : String;
        PositiveAnswer : localized String;
        NegativeAnswer : localized String;
        Description    : localized String;
        Mandatory      : Boolean;
        Event          : Association to Events;
}

entity Registrations : UserFields, ProjectFields {
    key ID      : UUID;
        Event   : Association to Events;
        Answers : Composition of Answers;
}

entity Attachments {
    key ID        : UUID;
        @Core.MediaType   : mediaType
        content   : LargeBinary;
        @Core.IsMediaType : true
        mediaType : String;
        Confirmed : Boolean;
        Internal  : Boolean;
}
