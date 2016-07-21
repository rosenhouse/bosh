module Bosh
  module Director
    module Models
      class RuntimeConfig < Sequel::Model(Bosh::Director::Config.db)
        def before_create
          self.created_at ||= Time.now
        end

        def manifest=(runtime_config_hash)
          self.properties = YAML.dump(runtime_config_hash)
        end

        def manifest
          manifest_hash = YAML.load(properties)
          Bosh::Director::RuntimeConfig::RuntimeManifestResolver.resolve_manifest(manifest_hash)
        end
      end
    end
  end
end
