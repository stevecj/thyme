def driver
  @driver ||= begin
    klass = defined?(Cucumber::Rails) ? ThymeRailsDriver : ThymeDomainDriver
    klass.new(self)
  end
end

After do
  next unless @driver ||= nil
  @driver.teardown
  @driver = nil
end
