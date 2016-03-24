module Danger
  class Dangerfile
    module DSL
      # Protect a file from being changed. This can
      # be used in combination with some kind of
      # permission check if a user is inside the org
      def protect_files(path: nil, message: nil, fail_build: true)
        raise "You have to provide a message" if message.to_s.length == 0
        raise "You have to provide a path" if path.to_s.length == 0

        broken_rule = false
        Dir.glob(path) do |current|
          broken_rule = true if self.env.scm.modified_files.include?(current)
        end

        return unless broken_rule

        if fail_build
          self.errors << message
        else
          self.messages << message
        end
      end
    end
  end
end
