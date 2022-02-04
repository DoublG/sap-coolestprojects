using {be.coolestprojects as my} from '../db/schema';
using {sap.common as sap} from '@sap/cds/common';


service AdminService @(requires : 'admin') {
  entity Events        as projection on my.Events actions {
    action openEvent();
    action closeEvent();
  };

  entity Questions     as projection on my.Questions;

  entity Registrations as projection on my.Registrations actions {
    action createUser();
    action resendMail();
  };

  entity Users         as projection on my.Users;
  entity Tshirts       as projection on my.Tshirts;
}
