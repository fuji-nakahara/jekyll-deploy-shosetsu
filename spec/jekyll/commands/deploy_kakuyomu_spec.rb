RSpec.describe Jekyll::Commands::DeployKakuyomu do
  describe '.process' do
    subject { described_class.process(options, deployer: JekyllDeployShosetsu::Deployers::Kakuyomu.new(client: client)) }

    let(:options) do
      {
        'source'   => source_dir,
        'email'    => email,
        'password' => password,
      }
    end
    let(:email) { 'dummy@example.com' }
    let(:password) { 'dummy_password' }

    let(:client) do
      spy('client').tap do |client|
        allow(client).to receive(:create_episode) { 'http://example.com/created-url' }
      end
    end

    before do
      reset_source_dir
    end

    it 'calls client methods' do
      subject

      expect(client).to have_received(:login!).with(email: email, password: password)
      expect(client).to have_received(:create_episode)
      expect(client).to have_received(:update_episode)
    end
  end
end