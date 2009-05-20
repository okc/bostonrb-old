ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

require 'spec'
require 'spec/rails'
require 'spec/interop/test'
require 'spec/autorun'

require 'shoulda'
require 'shoulda/test_unit'

class ActiveSupport::TestCase
  def file_fixture(name)
    File.read(File.join(File.dirname(__FILE__), "file_fixtures", name))
  end

  def assert_response_media_type(expected_content_type)
    actual_content_type = content_type

    msg = "Content Type '#{actual_content_type.inspect}' isn't '#{expected_content_type.inspect}'\n"
    msg += "Body: #{@response.body.first(100).chomp} ..." 

    assert_equal expected_content_type, actual_content_type, msg
  end

  def raw_content_type
    (@response.headers["Content-Type"] || @response.headers["type"]).to_s
  end

  def content_type
    raw_content_type.split(';').first
  end

  def self.should_have_media_type(media_type)
    should "have #{media_type.inspect} media type" do
      assert_response_media_type media_type
    end
  end

  def stubbed_action_view
    view = ActionView::Base.new(@controller.class.view_paths, {}, @controller)
    yield view
    ActionView::Base.stubs(:new).returns(view)
  end
end

# This hack is currently necessary to get spec/interop to pick up #should state
module Shoulda
  class Context
    def create_test_from_should_hash(should)
      test_name = ["test_", full_name, "should", "#{should[:name]}. "].flatten.join(' ').to_sym

      context = self
      test_unit_class.send(:define_method, test_name) do
        begin
          context.run_parent_setup_blocks(self)
          should[:before].bind(self).call if should[:before]
          context.run_current_setup_blocks(self)
          should[:block].bind(self).call
        ensure
          context.run_all_teardown_blocks(self)
        end
      end
    end
  end
end

# hack to get mocha working on rspec
# we should submit a patch to rspec since mocha renamed "standalone" to "api" (good job)
require 'mocha/api'
require 'mocha/object'
module Spec
  module Adapters
    module MockFramework
      include Mocha::API
      def setup_mocks_for_rspec
        mocha_setup
      end
      def verify_mocks_for_rspec
        mocha_verify
      end
      def teardown_mocks_for_rspec
        mocha_teardown
      end
    end
  end
end

class Object
  def stub_chain(*methods)
    while methods.length > 1 do
      stubs(methods.shift).returns(self)
    end
    stubs(methods.shift)
  end
end
