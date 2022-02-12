import type { Request } from "@sap/cds/apis/services"
import { Service } from "@sap/cds/apis/services";

export = (srv: Service) => {
  const { Events, Registration } = srv.entities;
  srv.on('openEvent', 'Events', async (req: Request) => {
    return req.error(500, "Not yet implemented")
  })
  srv.on('closeEvent', 'Events', async (req: Request) => {
    return req.error(500, "Not yet implemented")
  })
}