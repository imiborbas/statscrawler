class Website < ApplicationRecord
  def self.store(**args)
    record = find_by(domain: args[:domain])
    record.destroy if record

    create(args)
  end
end
