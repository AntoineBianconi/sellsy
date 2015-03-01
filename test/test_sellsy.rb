require 'helper'

class TestSellsy < Minitest::Test
  def setup
    Sellsy::Api.configure do |config|
      config.consumer_token = ENV['SELLSY_CONSUMER_TOKEN']
      config.consumer_secret = ENV['SELLSY_CONSUMER_SECRET']
      config.user_token = ENV['SELLSY_USER_TOKEN']
      config.user_secret = ENV['SELLSY_USER_SECRET']
    end
  end

  def test_that_all_clients_are_listed
    @clients = Sellsy::Clients.all

    ap @clients

    refute_equal 0, @clients.length
  end

  def test_that_client_is_created
    @client = Sellsy::Client.new
    @client.name = "Test Company #{Random.new_seed}"

    ap @client

    assert @client.create
  end

  def test_that_all_invoices_are_listed
    @invoices = Sellsy::Invoices.all

    ap @invoices

    refute_equal 0, @invoices.length
  end
end
