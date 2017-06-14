require 'rails_helper'

RSpec.describe 'Rate limit Rule', type: :request, order: :defined do
  let (:rule) { YAML.load_file("#{Rails.root}/config/rate-limit.yml")[Rails.env] }
  it 'returns proper not rate-limited response' do
    rule['requests'].times do
      get root_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to eql('OK')
    end
  end

  it 'returns proper warning if rate-limited' do
    get root_path

    expect(response).to have_http_status(429)
    expect(response.body).to match(/Rate limit exceeded/)
  end
end
