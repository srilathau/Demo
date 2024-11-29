
namespace com.sri.database;
using {managed, cuid} from '@sap/cds/common';

entity productlocal : cuid, managed {
  key Product: String(40);
    ProductType: String(4);
    BaseUnit: String(3);
    ProductGroup: String(18);
    ProductDescription: String(40);
    ProductPlant: String(20);
}


