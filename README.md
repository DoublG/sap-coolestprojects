# Coolestprojects SAP Version

This project is a variant of the coolesprojects website.

I'm using this project to learn the various capabilities of Fiori Elements & test cloud infrastucture capabilities.

## Things to learn

* CAP capabilities & way of working
* Annotations spielerei (how to mess around with UI5 features)
  * XML preprocessor
  * Custom controls
  * Backend validation & UI adaptations (hide fields, mandatory, ...)
* Non SAP frontend (Vue)
* Analytical apps
* Working with streaming data
* Overview pages
* Security
* Automate tooling & testing

## Deployment steps

    cds build --production
    cf cspush
    cf logs sap-coolestprojects-db-deployer --recent
