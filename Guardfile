# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, cli: "--color --tty --format doc spec" do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
  watch(%r{^spec/(.+)/(.+)_spec\.rb$}) { |m| "spec/#{m[1]}/#{m[2]}_spec.rb" }

  watch(%r{^companies/app/(.+)\.rb$})   { |m| "spec/integration/companies_spec.rb" }
end

