require "spec_helper"

module RockConfig
  describe Config do
    it "accepts a hash" do
      hash = {:foo => "bar"}

      config = Config.new(hash)
      config.raw.should eq(hash)
    end

    it "returns config for given environment" do
      subhash_dev  = {"a" => 123}
      subhash_prod = {"a" => 321}
      hash = {
        "development" => subhash_dev,
        "production"  => subhash_prod
      }

      config = Config.new(hash)
      config.development.raw.should eq(subhash_dev)
      config.production.raw.should eq(subhash_prod)
    end

    it "returns nil when asked for non existing environment" do
      config = Config.new({})
      config.for_environment("I do not exist").should be_nil
    end

    it "returns correct values when asked for" do
      hash = {
        "development" => {
          "host" => "localhost"
        }
      }

      config = Config.new(hash)
      config.development.host.should eq("localhost")
    end

    it "returns correct nested values when asked for" do
      hash = {
        "development" => {
          "elastic" => {
            "host" => "localhost"
          }
        }
      }

      config = Config.new(hash)
      config.development.elastic.host.should eq("localhost")
    end
  end
end
