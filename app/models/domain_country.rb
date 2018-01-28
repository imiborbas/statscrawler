class DomainCountry < ApplicationRecord
  def self.store(**args)
    record = find_by(domain: args[:domain], country: args[:country])
    record.destroy if record

    create(args)
  end
end
