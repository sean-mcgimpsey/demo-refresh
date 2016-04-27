class Environment < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user

   validates :servername, presence: true, length: {minimum: 3, maximum: 50} 
   validates :location, presence: true,  length: {minimum: 3, maximum: 50}

  def self.host_online_check
    @environment = Environment.all
    @environment.each do |environment|
      if system("ping -c1 #{environment.servername}") then
        environment.update(:status => "Online")
      else environment.update(:status => "Offline")
      end
    end
  end

end



