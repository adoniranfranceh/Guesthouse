module AdminHelper
  def dynamic_url_inn
  	if current_admin.present? && current_admin.inn.try(:id).present?
  		return link_to 'Minha Pousada', inn_path(current_admin.inn.id) 
  	end
  	link_to 'Cadastrar Pousada', new_inn_path
  end
end
