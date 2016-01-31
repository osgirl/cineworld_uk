require_relative '../../../test_helper'
require_relative '../../../support/fixture_reader'

describe CineworldUk::Internal::ApiResponse do
  include Support::FixtureReader

  let(:described_class) { CineworldUk::Internal::ApiResponse }
  let(:standard) { 'key=ios&territory=GB' }

  describe '#cinema_list' do
    subject { described_class.new.cinema_list }

    before { stub_get("cinema/list?full=true&#{standard}", cinema_list_json) }

    it 'returns a string' do
      subject.class.must_equal String
    end
  end

  describe '#cinema_detail(cinema_id, date)' do
    subject { described_class.new.cinema_detail(3) }

    before do
      stub_get("cinema/detail?cinema=3&#{standard}", cinema_detail_json(3))
    end

    it 'returns a string' do
      subject.class.must_equal String
    end
  end

  describe '#film_list' do
    subject { described_class.new.film_list }

    before { stub_get("film/list?full=true&#{standard}", film_list_json) }

    it 'returns a string' do
      subject.class.must_equal String
    end
  end

  describe '#film_list_comingsoon' do
    subject { described_class.new.film_list_comingsoon }

    before do
      stub_get("film/list/comingsoon?full=true&#{standard}",
               film_list_comingsoon_json)
    end

    it 'returns a string' do
      subject.class.must_equal String
    end
  end

  describe '#performances(cinema_id, date)' do
    subject { described_class.new.performances(3, Date.today + 1) }

    before do
      stub_get("performances?cinema=3&date=20160201&#{standard}",
               performances_tomorrow_json(3))
    end

    it 'returns a string' do
      subject.class.must_equal String
    end
  end

  private

  def stub_get(site_path, response_body)
    url      = "http://www2.cineworld.co.uk/api/#{site_path}"
    response = { status: 200, body: response_body, headers: {} }
    stub_request(:get, url).to_return(response)
  end
end