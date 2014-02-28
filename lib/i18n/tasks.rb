require 'active_support/core_ext/hash'
require 'active_support/core_ext/string'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/object/blank'
require 'term/ansicolor'
require 'erubis'

require 'i18n/tasks/version'
require 'i18n/tasks/key'
require 'i18n/tasks/key_group'
require 'i18n/tasks/base_task'

module I18n
  module Tasks
    CONFIG_FILES = %w(
      config/i18n-tasks.yml config/i18n-tasks.yml.erb
      i18n-tasks.yml i18n-tasks.yml.erb
    )
    class << self
      def config
        file = CONFIG_FILES.detect { |f| File.exists?(f) }
        file = YAML.load(Erubis::Eruby.new(File.read(file)).result) if file
        HashWithIndifferentAccess.new.merge(file.presence || {})
      end
      include ::I18n::Tasks::Logging
    end
  end
end
