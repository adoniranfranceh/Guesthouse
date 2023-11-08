require 'rails_helper'

describe 'Visitante pesquisa por pousada' do

  it 'com o termo bairro' do
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
    Inn.create!(admin: admin, brand_name: 'Pousada Nascer do Sol', corporate_name: 'Sun LTDA',
                            registration_number: '38214597000140', phone: '(99)91999-1234', email: 'sun@email.com.br',
                            address: 'Rua do Norte, 100', neighborhood: 'Lago Negro', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada nascer do sol oferece vista para o mar.',
                            payment_methods: 'Crédito, Débito e Expresso', accepts_pets: false,
                            usage_policies: 'Não é permitido fumar', check_in: '16:00', check_out: '12:00', status: :active)

    # Act
    visit root_path
    within('nav') do
      fill_in 'Buscar por pousada', with: 'Centro'
      click_on 'Buscar'
    end

    # Assert
    expect(page).to have_content('Resultados da busca por Centro')
    expect(page).to have_content('1 pousada encontrada')
    expect(page).to have_content('Pousada Boa Vista')
    expect(page).not_to have_content('Pousada Árvore da Coruja')
    expect(page).not_to have_content('Pousada Nascer do Sol')
  end

   it 'com o termo cidade' do
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
    Inn.create!(admin: admin, brand_name: 'Pousada Nascer do Sol', corporate_name: 'Sun LTDA',
                            registration_number: '38214597000140', phone: '(99)91999-1234', email: 'sun@email.com.br',
                            address: 'Rua do Norte, 100', neighborhood: 'Lago Negro', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada nascer do sol oferece vista para o mar.',
                            payment_methods: 'Crédito, Débito e Expresso', accepts_pets: false,
                            usage_policies: 'Não é permitido fumar', check_in: '16:00', check_out: '12:00', status: :active)

    # Act
    visit root_path
    within('nav') do
      fill_in 'Buscar por pousada', with: 'Gramado'
      click_on 'Buscar'
    end

    # Assert
    expect(page).to have_content('2 pousadas encontradas')
    expect(page).not_to have_content('Pousada Boa Vista')
    expect(page).to have_content('Pousada Árvore da Coruja')
    expect(page).to have_content('Pousada Nascer do Sol')
  end

  it 'com o termo nome fantasia' do
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
    Inn.create!(admin: admin, brand_name: 'Pousada Nascer do Sol', corporate_name: 'Sun LTDA',
                            registration_number: '38214597000140', phone: '(99)91999-1234', email: 'sun@email.com.br',
                            address: 'Rua do Norte, 100', neighborhood: 'Lago Negro', state: 'RS',
                            city: 'Gramado', zip_code: ' 95670-000',
                            description: 'Pousada nascer do sol oferece vista para o mar.',
                            payment_methods: 'Crédito, Débito e Expresso', accepts_pets: false,
                            usage_policies: 'Não é permitido fumar', check_in: '16:00', check_out: '12:00', status: :active)

    # Act
    visit root_path
    within('nav') do
      fill_in 'Buscar por pousada', with: 'Pousada Boa Vista'
      click_on 'Buscar'
    end

    # Assert
    expect(page).to have_content('Pousada Boa Vista')
    expect(page).not_to have_content('Pousada Árvore da Coruja')
    expect(page).not_to have_content('Pousada Nascer do Sol')
  end

  it 'e não encontra pousada' do
    # Arrange
    admin = Admin.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    Inn.create!(admin: admin, brand_name: 'Pousada Boa Vista', corporate_name: 'Pousada Good LTDA',
                            registration_number: '94769049000157', phone: '(99)12122-1234', email: 'boavista@email.com.br',
                            address: 'Rua: Marcelo Déda', neighborhood: 'Centro', state: 'SE',
                            city: 'Canindé de São Francisco', zip_code: ' 95670-000',
                            description: 'Pousada de frente para o rio.',
                            payment_methods: 'Crédito e Débito', accepts_pets: true,
                            usage_policies: 'Não é permitido fumar', check_in: '15:00', check_out: '14:00', status: :active)
    # Act
    visit root_path
    within('nav') do
      fill_in 'Buscar por pousada', with: 'ksks'
      click_on 'Buscar'
    end

    # Assert
    expect(page).to have_content('Nennhum resultado para ksks')
    expect(page).not_to have_content('Pousada Boa Vista')
  end
end