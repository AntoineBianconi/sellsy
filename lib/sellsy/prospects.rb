require 'multi_json'

module Sellsy
  class Prospects
    attr_accessor :name
    attr_accessor :type
    attr_accessor :email
    attr_accessor :phone_number
    attr_accessor :siret
    attr_accessor :siren
    attr_accessor :rcs
    attr_accessor :corp_type
    attr_accessor :first_name
    attr_accessor :last_name
    attr_accessor :prospect_id
    attr_accessor :tags


    def initialize(opts = {})
      @name = opts[:name]
      @type = opts[:type]
      @email = opts[:email]
      @phone_number = opts[:phone_number]
      @siret = opts[:siret]
      @siren = opts[:siren]
      @rcs = opts[:rcs]
      @corp_type = opts[:corp_type]
      @tags = opts[:tags]
      @first_name = opts[:first_name]
      @last_name = opts[:last_name]
      @prospect_id = opts[:prospect_id]
    end


    def create
      command = {
          'method' => 'Prospects.create',
          'params' => {
              'third' => {
                  'name' => @name,
                  'type' => @type,
                  'email' => @email,
                  'tel' => @phone_number,
                  'siret' => @siret,
                  'siren' => @siren,
                  'rcs' => @rcs,
                  'corpType' => @corp_type,
                  'tags' => @tags,
              },
              'contact' => {
                  'name' => "#{@first_name} #{@last_name}",
                  'email' => @email,
                  'tel' => @phone_number
              }
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      @id = response['response']

      return response['status'] == 'success'
    end

    def add_contact
      command = {
          'method' => 'Prospects.addContact',
          'params' => {
              'prospectid' => @prospect_id,
              'third' => {
                  'name' => "#{@first_name} #{@last_name}",
                  'email' => @email,
                  'tel' => @phone_number
              }
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      @id = response['response']['contact_id']

      return response['status'] == 'success'
    end

  end

end
