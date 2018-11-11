RSpec.describe Jekyll::Commands::DeployNarou do
  describe '.process' do
    subject { described_class.process(options, deployer: JekyllDeployShosetsu::Deployers::Narou.new(agent: agent)) }

    let(:options) do
      {
        'source' => source_dir,
        'narou'  => {
          'id'       => id,
          'password' => password,
        },
      }
    end
    let(:id) { 'dummy_id' }
    let(:password) { 'dummy_password' }

    let(:agent) do
      spy('agent').tap do |agent|
        allow(agent).to receive(:create_part) { 'https://syosetu.com/usernoveldatamanage/top/ncode/6759324/noveldataid/100000000/' }
        allow(agent).to receive(:update_part) { 'https://syosetu.com/usernoveldatamanage/top/ncode/6759324/noveldataid/99999999/' }
      end
    end

    before do
      reset_source_dir
    end

    it 'calls agent methods' do
      subject

      expect(agent).to have_received(:login!).with(id: id, password: password)
      expect(agent).to have_received(:create_part)
      expect(agent).to have_received(:update_part)
    end
  end
end
