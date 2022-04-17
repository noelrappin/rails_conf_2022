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
class Person < ApplicationRecord
  def self.null_person = OpenStruct.new(initials: "", name: "No Person", id: 0)

  def self.edit_people_list = all.sort_by(&:name) << null_person
end
