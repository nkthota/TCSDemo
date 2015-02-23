require 'rspec'
require 'spec_helper'
require 'selenium-webdriver'
require 'tiny_tds'

class DataDriver

  def gettestdata(id)
    retvalue = ''
    client = TinyTds::Client.new username: 'sa', password: 'Password1', dataserver: 'localhost\SQLEXPRESS' , database:'tcsdemo'
    #expect(client.active?).to be true
    result = client.execute('SELECT input_data FROM tcs_data where uid=' + id.to_s )
    result.each do |row|
      retvalue =  row['input_data']
    end
    client.close
    return retvalue
  end
end