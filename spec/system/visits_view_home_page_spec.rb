require 'rails_helper'

describe 'Visitante entram na página principal' do
  it 'e vê pousadas' do
  	# Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvere@email.com.br',
                address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                city: 'Gramado', zip_code: ' 95670-000',
                description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                payment_methods: 'Crédito e Débito', accepts_pets: true,
                usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    Inn.create!(admin: admin, brand_name: 'Pousada Vale das Orquídeas', corporate_name: 'Pousada Orquídeas LTDA',
                registration_number: '14368007000175', phone: '(99)99999-1234', email: 'valedasorquideas@email.com.br',
                address: 'Rua: João Alfredo Schneider, 1000', neighborhood: 'Planalto', state: 'RS',
                city: 'Gramado', zip_code: ' 95670-000',
                description: 'Pousada Vale das Orquídeas fundada em 1997.',
                payment_methods: 'Crédito e Débito', accepts_pets: true,
                usage_policies: 'Não é permitido fumar', check_in: '12:00', check_out: '11:00', status: :active)
    Inn.create!(admin: admin, brand_name: 'Pousada Ilha Vitoria', corporate_name: 'Pousada Vitoria LTDA',
                registration_number: '43747154000154', phone: '(99)91555-1234', email: 'ilhavitoria@email.com.br',
                address: 'Rua: Coberta, 290', neighborhood: 'Centro', state: 'RS',
                city: 'Gramado', zip_code: ' 95670-000',
                description: 'Pousada Ilha da Vitoria com diversos quartos temáticos.',
                payment_methods: 'Crédito, Débito e Pix', accepts_pets: false,
                usage_policies: 'Não é permitido fumar', check_in: '14:00', check_out: '12:00', status: :active)
    Inn.create!(admin: admin, brand_name: 'Pousada Natribus Rosa', corporate_name: 'Pousada Natribus LTDA',
                registration_number: '94769049000157', phone: '(99)95432-1234', email: 'natribusrosa@email.com.br',
                address: 'Rua: Torta, 100', neighborhood: 'Centro', state: 'RS',
                city: 'Gramado', zip_code: ' 95670-000',
                description: 'Pousada Natribus Rosa com ótima vista para o campo.',
                payment_methods: 'Crédito e Débito', accepts_pets: true,
                usage_policies: 'Não é permitido fumar', check_in: '15:30', check_out: '14:30', status: :active)


  	# Act
  	visit root_path

  	# Assert
    expect(page).to have_content('Pousadas')
    within('#rest_of_the_inns') do
      expect(page).to have_content('Pousada Árvore da Coruja')
      expect(page).not_to have_content('Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.')
      expect(page).to have_content('Gramado')
      expect(page).not_to have_content('Não existem pousadas cadastradas')
    end
    within('#recent_inns') do
      expect(page).to have_content('Pousadas Recentes')
      expect(page).not_to have_content('Pousada Árvore da Coruja')
      expect(page).to have_content('Pousada Vale das Orquídeas')
      expect(page).to have_content('Gramado')
      expect(page).to have_content('Pousada Ilha Vitoria')
      expect(page).to have_content('Gramado')
      expect(page).to have_content('Pousada Natribus Rosa')
      expect(page).to have_content('Gramado')
      expect(page).not_to have_content('Não existem pousadas cadastradas')
    end
  end

  it 'e não existem pousadas' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_content('Não existem pousadas cadastradas')
  end

  it 'e pousada não está ativa' do
    # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                            registration_number: '24469244000186', phone: '(99)91234-1234', email: 'arvere@email.com.br',
                            address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    Inn.create!(admin: admin, brand_name: 'Pousada Nascer do Sol', corporate_name: 'Sun LTDA',
                            registration_number: '38214597000140', phone: '(99)91235-1234', email: 'sun@email.com.br',
                            address: 'Rua do Norte, 100', neighborhood: 'Lago Negro', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada nascer do sol oferece vista para o mar.',
                            payment_methods: 'Crédito, Débito e Expresso', accepts_pets: false,
                            usage_policies: 'Não é permitido fumar', check_in: '16:00', check_out: '12:00', status: :inactive)
    # Act
    visit root_path

    # Assert
    expect(page).to have_content('Pousadas')
    expect(page).to have_content('Pousada Árvore da Coruja')
    expect(page).not_to have_content('Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.')
    expect(page).to have_content('Gramado')
    expect(page).not_to have_content('Pousada Nascer do Sol')
  end

  it 'e podem ver pousadas de acordo com cidade' do
    # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    Inn.create!(admin: admin, brand_name: 'Pousada Boa Vista', corporate_name: 'Pousada Good LTDA',
                            registration_number: '94769049000157', phone: '(99)12122-1234', email: 'boavista@email.com.br',
                            address: 'Rua: Marcelo Déda', neighborhood: 'Centro', state: 'SE',
                            city: 'Canindé de São Francisco', zip_code: ' 95670-000',
                            description: 'Pousada de frente para o rio.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    Inn.create!(admin: admin, brand_name: 'Pousada Árvore da Coruja', corporate_name: 'Pousada Guest LTDA',
                            registration_number: '24469244000186', phone: '(99)94444-1234', email: 'arvere@email.com.br',
                            address: 'Rua: Pedro Candiago, 725', neighborhood: 'Planalto', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada Árvore Da Coruja oferece acomodação com lounge compartilhado.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    # Act
    visit root_path
    within('#choose_city') do
      click_on 'Gramado'
    end
    # Assert
    expect(page).not_to have_content('Reservas')
    expect(page).not_to have_content('Estadias Ativas')
    expect(page).to have_content('Pousadas de Gramado')
    expect(page).to have_content('Pousada Árvore da Coruja')
    expect(page).not_to have_content('Pousada Boa Vista')
  end
end
