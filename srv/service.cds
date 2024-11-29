using {com.sri.database as db} from '../db/schema';
using {API_PRODUCT_SRV as productdb} from './external/API_PRODUCT_SRV';

service MyService {

    entity productlocal       as projection on db.productlocal;

    entity product            as
        projection on productdb.A_Product {
             Product,
    ProductType,
    BaseUnit,
    ProductGroup,
    to_Description,
    null as ProductDescription: String(80),
            to_Plant,
            null as ProductPlant       : String(20)

        };

    entity productdescription as projection on productdb.A_ProductDescription {
            Product,
            Language,
            ProductDescription

        };

    entity productplant       as
        projection on productdb.A_ProductPlant {
            Product,
            BaseUnit,
            Plant,
        };

}


annotate MyService.productlocal with @odata.draft.enabled;

annotate MyService.productlocal with @(UI.LineItem: [
    {
        Label: 'Product',
        Value: Product
    },
    {
        Label: 'Product Type',
        Value: ProductType
    },
    {
        Label: 'Base Unit',
        Value: BaseUnit
    },
    {
        Label: 'Product Group',
        Value: ProductGroup
    },
    {
        Label: 'Product Description',
        Value: ProductDescription
    },
    {
        Label: 'Product Plant',
        Value: ProductPlant
    },

]);

annotate MyService.productlocal with @(
    UI.FieldGroup #Kitchen: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Product',
                Value: Product
            },
            {
                $Type: 'UI.DataField',
                Label: 'Product Type',
                Value: ProductType
            },
            {
                $Type: 'UI.DataField',
                Label: 'Base Unit',
                Value: BaseUnit
            },
            {
                $Type: 'UI.DataField',
                Label: 'Product Group',
                Value: ProductGroup
            },
            {
                $Type: 'UI.DataField',
                Label: 'Product Description',
                Value: ProductDescription
            },
            {
                $Type: 'UI.DataField',
                Label: 'Product Plant',
                Value: ProductPlant
            },

        ]
    },
    UI.Facets             : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'productlocalFacet',
        Label : 'product local Details',
        Target: '@UI.FieldGroup#Kitchen',
    }, ],

);
