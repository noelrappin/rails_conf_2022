# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  initials   :string
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Person, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
