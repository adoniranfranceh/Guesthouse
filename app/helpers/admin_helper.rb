module AdminHelper
  def dynamic_link_inn
    if admin_signed_in? && current_admin.inn.try(:id).present?
      link_to 'Minha Pousada', admin_show_inn_path(current_admin.inn.id)
    else
      link_to 'Cadastrar Pousada', new_inn_path
    end
  end
end
