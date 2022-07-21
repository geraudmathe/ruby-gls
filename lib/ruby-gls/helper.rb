class RubyGLS
  module Helper
    def replace_string(full, substring, to_replace)
      full.sub!(substring, to_replace.to_s)
    end
  end
end