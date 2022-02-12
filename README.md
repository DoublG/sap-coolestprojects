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

## Gotchas

* generate guids via uuidgen
* fill in GUIDs in CSV files
* mind the inconsistencies between sqllite & hana CDS syntax
* Check the location of your annotations for graphs, otherwise associations are used incorrectly (distribution graph was using the events instead of thirts)
