using {be.coolestprojects as my} from '../db/schema';
using {sap.common as sap} from '@sap/cds/common';

service AdminService @(requires : 'admin') {

  entity TotalRegistrations as projection on my.TotalRegistrations {
    key EventId, TotalRegistrations : Decimal, RemainingRegistrations : Decimal
  };

  entity DistinctSex        as projection on my.DistinctSex {
    key EventId, key ID : String, Name : String, Total : Decimal
  };

  entity DistinctTshirt     as projection on my.DistinctTshirt {
    key EventId, key ID, Name : String, Total : Decimal
  };

  entity TotalUsers         as projection on my.TotalUsers {
    key EventId, TotalUsers : Decimal
  };


  entity Events             as
    select from my.Events {
      * ,
      Registrations : redirected to Registrations,
      Users         : redirected to Users
    } actions {
      action openEvent();
      action closeEvent();
    };

  entity Questions          as projection on my.Questions {
    * , Event : redirected to Events
  };

  entity Registrations      as projection on my.Registrations {
    * , Event : redirected to Events
  } actions {
    action createUser();
    action resendMail();
  };

  entity Users              as projection on my.Users;
  entity Tshirts            as projection on my.Tshirts;
  entity Sex                as projection on my.Sex;
}
