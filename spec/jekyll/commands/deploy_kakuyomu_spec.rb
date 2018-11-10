RSpec.describe Jekyll::Commands::DeployKakuyomu do
  describe '.process' do
    subject { described_class.process(options, deployer: JekyllDeployShosetsu::Deployers::Kakuyomu.new(agent: agent)) }

    let(:options) do
      {
        'source'   => source_dir,
        'kakuyomu' => {
          'email'    => email,
          'password' => password,
        },
      }
    end
    let(:email) { 'dummy@example.com' }
    let(:password) { 'dummy_password' }

    let(:agent) do
      spy('agent').tap do |agent|
        allow(agent).to receive(:create_episode) { 'https://kakuyomu.jp/works/1234567890123456789/episodes/1234567890123456789' }
        allow(agent).to receive(:update_episode) { 'https://kakuyomu.jp/works/1234567890123456789/episodes/1234567890123456790' }
      end
    end

    before do
      reset_source_dir
    end

    it 'calls agent methods' do
      subject

      expect(agent).to have_received(:login!).with(email: email, password: password)
      expect(agent).to have_received(:create_episode)
      expect(agent).to have_received(:update_episode)
    end
  end
end
