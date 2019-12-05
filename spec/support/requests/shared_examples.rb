# frozen_string_literal: true

RSpec.shared_examples 'admin authorized-only resource' do |action|
  subject(:access) { send action.to_sym, endpoint, params: defined?(params) && params || {} }

  let(:error_message) { "Sorry, you aren't allowed to do that. You've been redirected to your previous page instead." }

  it 'authorizes admin users' do
    sign_in users(:admin)
    access

    expect(flash[:error]).not_to eq(error_message)
  end

  it 'does not authorize member users' do
    sign_in users(:member)
    access

    expect(response).to have_http_status(:found)
    expect(flash[:error]).to eq(error_message)
  end
end

RSpec.shared_examples 'admin and volunteer authorized-only resource' do |action|
  subject(:access) { send action.to_sym, endpoint, params: defined?(params) && params || {} }

  let(:error_message) { "Sorry, you aren't allowed to do that. You've been redirected to your previous page instead." }

  it 'authorizes admin users' do
    sign_in users(:admin)
    access

    expect(flash[:error]).not_to eq(error_message)
  end

  it 'authorizes volunteer users' do
    sign_in users(:volunteer)
    access

    expect(flash[:error]).not_to eq(error_message)
  end

  it 'does not authorize member users' do
    sign_in users(:member)
    access

    expect(response).to have_http_status(:found)
    expect(flash[:error]).to eq(error_message)
  end
end
