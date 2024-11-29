const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    // Connect to the external OData service
    const pp = await cds.connect.to('API_PRODUCT_SRV');

    // Handle the 'READ' event for 'InspectionReport'
    this.on('READ', 'product', async req => {
        // Forward the query to the external service and return the result

     req.query.SELECT.columns = [
     {ref: ['Product'] },
     {ref: ['ProductType'] },
     {ref: ['ProductGroup'] },
     {ref: ['BaseUnit'] },
     {ref: ['to_Description'] , expand: ['*'] },
     {ref: ['to_Plant'] , expand: ['*'] },
     ]
      let res = await pp.run(req.query);
      res.forEach(element => {
        if (Array.isArray(element.to_Description)) {
            element.to_Description.forEach(plan=> {
                if(plan.Language = 'EN') {
                    element.ProductDescription = plan.ProductDescription
                }

            } )
        }
       if (Array.isArray(element.to_Plant)) {
            element.to_Plant.forEach(item=> {
                if(item.BaseUnit = 'TO') {
                    element.ProductPLT = item.Plant
                }
            });
        }
      });
        return res;
    });
    
});
