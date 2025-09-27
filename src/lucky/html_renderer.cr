require "./tags/**"

class Lucky::HTMLRenderer
  include Lucky::BaseTags
  include Lucky::CustomTags

  getter view : IO

  def initialize(@view : IO)
  end
end
