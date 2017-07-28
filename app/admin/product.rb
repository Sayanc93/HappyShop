ActiveAdmin.register Product do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name,
              :sold_out,
              :under_sale,
              :price_in_cents,
              :sale_price_in_cents,
              :sale_text
end
