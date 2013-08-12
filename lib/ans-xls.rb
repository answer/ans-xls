require "ans-xls/version"

module Ans
  module Xls
    autoload "Helper", "ans-xls/helper.rb"

    include ActiveSupport::Configurable

    configure do |config|
      config.author = "management"
    end

    class Engine < Rails::Engine
      initializer "ans-xls add mime type xls" do |app|
        Mime::Type.register "application/vnd.ms-excel", :xls
      end
    end
  end
end
