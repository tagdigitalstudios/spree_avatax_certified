Spree.user_class.class_eval do
  has_one :avalara_use_code_item, class_name: 'Spree::AvalaraUseCodeItem'
end
