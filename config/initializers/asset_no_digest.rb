module Sprockets
  # We need to link remotely to css and javascript files for this application, so we override the digest paths
  class Asset
    def digest_path
      logical_path
    end

    def dependency_fresh?(environment, dep)
      false
    end
  end
end
